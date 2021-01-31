//
//  MyProfileViewModel.swift
//  Monotone
//
//  Created by Xueliang Chen on 2021/1/31.
//

import Foundation

import RxSwift
import RxRelay
import Action
import RxSwiftExt

class MyProfileViewModel: BaseViewModel, ViewModelStreamable{
    
    // MARK: - Input
    struct Input {
        var username: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
        var profileContent: BehaviorRelay<ProfileContent?> = BehaviorRelay<ProfileContent?>(value: nil)
        
        var loadMoreAction: Action<Void, [Any]>?
        var reloadAction: Action<Void, [Any]>?
    }
    public var input: Input = Input()
    
    // MARK: - Output
    struct Output {
        var user: BehaviorRelay<User?> = BehaviorRelay<User?>(value: nil)
        var statistics: BehaviorRelay<Statistics?> = BehaviorRelay<Statistics?>(value: nil)

        var photos: BehaviorRelay<[Photo]> = BehaviorRelay<[Photo]>(value: [])
        var collections: BehaviorRelay<[Collection]> = BehaviorRelay<[Collection]>(value: [])
        var likedPhotos: BehaviorRelay<[Photo]> = BehaviorRelay<[Photo]>(value: [])
        
        var loadingMore: PublishRelay<Bool> = PublishRelay<Bool>()
        var reloading: PublishRelay<Bool> = PublishRelay<Bool>()
    }
    public var output: Output = Output()
    
    // MARK: - Private
    private var photoNextLoadPage: Int = 1
    private var currentPhotos: [Photo] = []
    private var emptyPhotos: [Photo] = Array(repeating: Photo(), count: 10)
    
    private var collectionNextLoadPage: Int = 1
    private var currentCollections: [Collection] = []
    private var emptyCollections: [Collection] = Array(repeating: Collection(), count: 10)
    
    private var likedPhotoNextLoadPage: Int = 1
    private var currentLikedPhotos: [Photo] = []
    private var emptyLikedPhotos: [Photo] = Array(repeating: Photo(), count: 10)
    
    // MARK: - Inject
    override func inject(args: [String : Any?]?) {
        if let username = args?["username"]{
            self.input.username = BehaviorRelay(value: username as? String)
        }
    }
    
    // MARK: - Bind
    override func bind() {
        
        // Service.
        let userService = self.service(type: UserService.self)!
        
        // Binding.
        // User.
        self.input.username
            .unwrap()
            .flatMap({ (username) -> Observable<Statistics> in
                return userService.statisticizeUser(username: username)
            })
            .bind(to: self.output.statistics)
            .disposed(by: self.disposeBag)
        
        self.input.username
            .unwrap()
            .flatMap({ (username) -> Observable<User> in
                return userService.getMineProfile()
            })
            .bind(to: self.output.user)
            .disposed(by: self.disposeBag)
        
        // LoadMore.
        self.input.loadMoreAction = Action<Void, [Any]>(workFactory: { [weak self] _ -> Observable<[Any]> in
            guard let self = self else { return Observable.empty() }
            
            self.output.loadingMore.accept(true)
            
            if let username = self.input.username.value{
                if(self.input.profileContent.value == .photos){
                    
                    self.output.photos.accept(self.currentPhotos + self.emptyPhotos)
                    return userService.listUserPhotos(username: username, page: self.photoNextLoadPage, perPage: 20)
                        .map({ $0 as [Any] })
                }
                else if(self.input.profileContent.value == .collections){
                    
                    self.output.collections.accept(self.currentCollections + self.emptyCollections)
                    return userService.listUserCollections(username: username, page: self.collectionNextLoadPage, perPage: 20)
                        .map({ $0 as [Any] })
                }
                else if(self.input.profileContent.value == .likedPhotos){
                    
                    self.output.likedPhotos.accept(self.currentLikedPhotos + self.emptyLikedPhotos)
                    return userService.listUserLikedPhotos(username: username, page: self.likedPhotoNextLoadPage, perPage: 20)
                        .map({ $0 as [Any] })
                }

            }
            
            return Observable.empty()
        })
        
        self.input.loadMoreAction?.elements
            .subscribe(onNext: { [weak self] (elements) in
                guard let self = self else { return }
                
                if self.input.profileContent.value == .photos, let photos = elements as? [Photo]{
                    self.currentPhotos = self.photoNextLoadPage == 1 ? photos : self.currentPhotos + photos
                    self.photoNextLoadPage += 1
                    self.output.photos.accept(self.currentPhotos)
                }
                else if self.input.profileContent.value == .collections, let collections = elements as? [Collection]{
                    self.currentCollections = self.collectionNextLoadPage == 1 ? collections : self.currentCollections + collections
                    self.collectionNextLoadPage += 1
                    self.output.collections.accept(self.currentCollections)
                }
                else if self.input.profileContent.value == .likedPhotos, let likedPhotos = elements as? [Photo]{
                    self.currentLikedPhotos = self.likedPhotoNextLoadPage == 1 ? likedPhotos : self.currentLikedPhotos + likedPhotos
                    self.likedPhotoNextLoadPage += 1
                    self.output.likedPhotos.accept(self.currentLikedPhotos)
                }
                                
                self.output.loadingMore.accept(false)
            })
            .disposed(by: self.disposeBag)
        
        self.input.loadMoreAction?.errors
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                
                self.output.photos.accept(self.currentPhotos)
                self.output.collections.accept(self.currentCollections)
                self.output.likedPhotos.accept(self.currentLikedPhotos)

                self.output.loadingMore.accept(false)
            })
            .disposed(by: self.disposeBag)
        
        // Reload.
        self.input.reloadAction = Action<Void, [Any]>(workFactory: { [weak self](_) -> Observable<[Any]> in
            guard let self = self else { return Observable.empty() }
            
            self.output.reloading.accept(true)

            if let loadMoreAction = self.input.loadMoreAction{
                
                if(self.input.profileContent.value == .photos){
                    self.photoNextLoadPage = 1
                }
                else if(self.input.profileContent.value == .collections){
                    self.collectionNextLoadPage = 1
                }
                else if(self.input.profileContent.value == .likedPhotos){
                    self.likedPhotoNextLoadPage = 1
                }
 
                return loadMoreAction.execute()
            }
            
            return Observable.empty()
        })
        
        self.input.reloadAction?.elements
            .subscribe(onNext: { [weak self] (photos) in
                guard let self = self else { return }
                
                self.output.reloading.accept(false)
            })
            .disposed(by: self.disposeBag)
        
        self.input.reloadAction?.errors
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                
                self.output.reloading.accept(false)
            })
            .disposed(by: self.disposeBag)
        
    }
    
}
