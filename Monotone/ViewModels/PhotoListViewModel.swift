//
//  PhotoListViewModel.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/19.
//

import Foundation

import RxSwift
import RxRelay
import Action
import RxSwiftExt

class PhotoListViewModel: BaseViewModel, ViewModelStreamable{
    
    // MARK: - Input
    struct Input {
        var searchQuery: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
        var listOrderBy: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
        var topic: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
        var loadMoreAction: Action<Void, [Photo]>?
        var reloadAction: Action<Void, [Photo]>?
    }
    public var input: Input = Input()
    
    // MARK: - Output
    struct Output {
        var photos: BehaviorRelay<[Photo]> = BehaviorRelay<[Photo]>(value: [])
        var loadingMore: PublishRelay<Bool> = PublishRelay<Bool>()
        var reloading: PublishRelay<Bool> = PublishRelay<Bool>()
    }
    public var output: Output = Output()
    
    // MARK: - Private
    private var nextLoadPage: Int = 1
    private var currentPhotos: [Photo] = []
    private var emptyPhotos: [Photo] = Array(repeating: Photo(), count: 10)
    
    // MARK: - Inject
    override func inject(args: [String : Any?]?) {
        if let searchQuery = args?["searchQuery"]{
            self.input.searchQuery = BehaviorRelay(value: searchQuery as? String)
        }
        if let listOrderBy = args?["listOrderBy"]{
            self.input.listOrderBy = BehaviorRelay(value: listOrderBy as? String)
        }
    }
    
    // MARK: - Bind
    override func bind() {
        
        // Service
        let photoService = self.service(type: PhotoService.self)!
        let topicService = self.service(type: TopicService.self)!
        
        // Binding
        // LoadMore.
        self.input.loadMoreAction = Action<Void, [Photo]>(workFactory: { [weak self] _ -> Observable<[Photo]> in
            guard let self = self else { return Observable.empty() }
            
            self.output.loadingMore.accept(true)
            
            // Before the request returns.
            self.output.photos.accept((self.currentPhotos) + (self.emptyPhotos))
            
            if let listOrderBy = self.input.listOrderBy.value{
                return photoService.listPhotos(page: self.nextLoadPage, perPage: 20, orderBy: listOrderBy)
            }
            else if let searchQuery = self.input.searchQuery.value{
                return photoService.searchPhotos(query: searchQuery , page: self.nextLoadPage, perPage: 20)
            }
            else if let topic = self.input.topic.value{
                return topicService.getTopicPhotos(idOrSlug: topic, page: self.nextLoadPage, perPage: 20)
            }
            else{
                self.output.loadingMore.accept(false)
            }
            
            return Observable.empty()
        })
        
        self.input.loadMoreAction?.elements
            .subscribe(onNext: { [weak self] (photos) in
                guard let self = self else { return }
                
                self.currentPhotos = self.nextLoadPage == 1 ? photos : self.currentPhotos + photos
                self.nextLoadPage += 1

                self.output.photos.accept(self.currentPhotos)
                
                self.output.loadingMore.accept(false)
            })
            .disposed(by: self.disposeBag)
        
        self.input.loadMoreAction?.errors
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                
                self.output.photos.accept(self.currentPhotos)

                self.output.loadingMore.accept(false)
            })
            .disposed(by: self.disposeBag)
        
        // Reload.
        self.input.reloadAction = Action<Void, [Photo]>(workFactory: { [weak self](_) -> Observable<[Photo]> in
            guard let self = self else { return Observable.empty() }
            
            self.output.reloading.accept(true)

            if let loadMoreAction = self.input.loadMoreAction{
                self.nextLoadPage = 1
                
                // Before the request returns.
                self.output.photos.accept(self.emptyPhotos)
                
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
        
        // Search query.
        self.input.searchQuery
            .distinctUntilChanged()
            .unwrap()
            .subscribe { [weak self] (_) in
                guard let self = self else { return }
                
                self.input.listOrderBy.accept(nil)
                self.input.topic.accept(nil)
                self.input.reloadAction?.execute()
            }
            .disposed(by: self.disposeBag)
        
        // Order by.
        self.input.listOrderBy
            .distinctUntilChanged()
            .unwrap()
            .subscribe { [weak self] (_) in
                guard let self = self else { return }
                
                self.input.searchQuery.accept(nil)
                self.input.topic.accept(nil)
                self.input.reloadAction?.execute()
            }
            .disposed(by: self.disposeBag)
        
        // Topic.
        self.input.topic
            .distinctUntilChanged()
            .unwrap()
            .subscribe { [weak self] (_) in
                guard let self = self else { return }
                
                self.input.searchQuery.accept(nil)
                self.input.listOrderBy.accept(nil)
                self.input.reloadAction?.execute()
            }
            .disposed(by: self.disposeBag)
    }
    
}
