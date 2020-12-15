//
//  PhotoAddToCollectionViewModel.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/7.
//

import Foundation

import RxSwift
import RxRelay
import Action

class PhotoAddToCollectionViewModel: BaseViewModel, ViewModelStreamable{
    
    // MARK: - Input
    struct Input {
        var username: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
        var loadMoreAction: Action<Void, [Collection]>?
        var reloadAction: Action<Void, [Collection]>?
        
        var photo: BehaviorRelay<Photo?> = BehaviorRelay<Photo?>(value: nil)
        var collection: BehaviorRelay<Collection?> = BehaviorRelay<Collection?>(value: nil)
        var addToCollectionAction: Action<Void, Photo?>?
        var removeFromCollectionAction: Action<Void, Photo?>?
    }
    public var input: Input = Input()
    
    // MARK: - Output
    struct Output {
        var collections: BehaviorRelay<[Collection]> = BehaviorRelay<[Collection]>(value: [])
        var loadingMore: PublishRelay<Bool> = PublishRelay<Bool>()
        var reloading: PublishRelay<Bool> = PublishRelay<Bool>()
        
        var addedPhoto: BehaviorRelay<Photo?> = BehaviorRelay<Photo?>(value: nil)
        var addingToCollection: PublishRelay<Bool> = PublishRelay<Bool>()
        var removedPhoto: BehaviorRelay<Photo?> = BehaviorRelay<Photo?>(value: nil)
        var removingFromCollection: PublishRelay<Bool> = PublishRelay<Bool>()
    }
    public var output: Output = Output()
    
    // MARK: - Private
    private var nextLoadPage: Int = 1
    
    // MARK: - Inject
    override func inject(args: [String : Any]?) {
        if let username = args?["username"]{
            self.input.username = BehaviorRelay(value: username as? String)
        }
        if let photo = args?["photo"]{
            self.input.photo = BehaviorRelay(value: photo as? Photo)
        }
    }
    
    // MARK: - Bind
    override func bind() {
        
        // Service.
        let userService = self.service(type: UserService.self)!
        let collectionService = self.service(type: CollectionService.self)!
        
        // Bindings.
        // LoadMore.
        self.input.loadMoreAction = Action<Void, [Collection]>(workFactory: { (_) -> Observable<[Collection]> in
            self.output.loadingMore.accept(true)
                        
            return userService.listUserCollections(username: self.input.username.value!, page: self.nextLoadPage, perPage: 20)
        })
        
        self.input.loadMoreAction?.elements
            .subscribe(onNext: { (collections: [Collection]) in
                                
                self.output.collections.accept(self.nextLoadPage == 1 ? collections : self.output.collections.value + collections)
                self.nextLoadPage += 1
                
                self.output.loadingMore.accept(false)
            })
            .disposed(by: self.disposeBag)
        
        self.input.loadMoreAction?.errors
            .subscribe(onNext: { (_) in
                
                self.output.loadingMore.accept(false)
            })
            .disposed(by: self.disposeBag)
        
        // Reload.
        self.input.reloadAction = Action<Void, [Collection]>(workFactory: { (_) -> Observable<[Collection]> in
            self.output.reloading.accept(true)
            self.nextLoadPage = 1
            
            return self.input.loadMoreAction!.execute()
        })
        
        self.input.reloadAction?.elements
            .subscribe(onNext: { (collections: [Collection]) in
                
                self.output.collections.accept(collections)
                
                self.output.reloading.accept(false)
            })
            .disposed(by: self.disposeBag)
        
        self.input.reloadAction?.errors
            .subscribe(onNext: { (_) in
                
                self.output.reloading.accept(false)
            })
            .disposed(by: self.disposeBag)
        
        // addToCollection.
        self.input.addToCollectionAction = Action<Void, Photo?>(workFactory: { (_) -> Observable<Photo?> in
            self.output.addingToCollection.accept(true)

            return collectionService.addToCollection(collectionId: self.input.collection.value!.id!,
                                                     photoId: self.input.photo.value!.id!)
        })
        
        self.input.addToCollectionAction?.elements
            .subscribe(onNext: { (photo: Photo?) in

                if(photo != nil){
                    self.input.photo.accept(photo)
                }
                self.output.addedPhoto.accept(photo)
                
                self.output.addingToCollection.accept(false)
            })
            .disposed(by: self.disposeBag)
        
        self.input.addToCollectionAction?.errors
            .subscribe(onNext: { (_) in
                
                self.output.addedPhoto.accept(nil)
                
                self.output.addingToCollection.accept(false)
            })
            .disposed(by: self.disposeBag)
        
        // removeFromCollection.
        self.input.removeFromCollectionAction = Action<Void, Photo?>(workFactory: { (_) -> Observable<Photo?> in
            self.output.removingFromCollection.accept(true)

            return collectionService.removeFromCollection(collectionId: self.input.collection.value!.id!,
                                                          photoId: self.input.photo.value!.id!)
        })
        
        self.input.removeFromCollectionAction?.elements
            .subscribe(onNext: { (photo: Photo?) in

                if(photo != nil){
                    self.input.photo.accept(photo)
                }
                self.output.removedPhoto.accept(photo)
                
                self.output.removingFromCollection.accept(false)
            })
            .disposed(by: self.disposeBag)
        
        self.input.removeFromCollectionAction?.errors
            .subscribe(onNext: { (_) in
                
                self.output.removedPhoto.accept(nil)
                
                self.output.removingFromCollection.accept(false)
            })
            .disposed(by: self.disposeBag)
    }
}
