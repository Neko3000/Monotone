//
//  CollectionDetailsViewModel.swift
//  Monotone
//
//  Created by Xueliang Chen on 2021/1/20.
//

import Foundation

import RxSwift
import RxRelay
import Action
import RxSwiftExt

class CollectionDetailsViewModel: BaseViewModel, ViewModelStreamable{
    
    // MARK: - Input
    struct Input {
        var collection: BehaviorRelay<Collection?> = BehaviorRelay<Collection?>(value: nil)

        var loadMoreAction: Action<Void, [Photo]>?
        var reloadAction: Action<Void, [Photo]>?
    }
    public var input: Input = Input()
    
    // MARK: - Output
    struct Output {
        var loadingMore: PublishRelay<Bool> = PublishRelay<Bool>()
        var reloading: PublishRelay<Bool> = PublishRelay<Bool>()
        
        var photos: BehaviorRelay<[Photo]> = BehaviorRelay<[Photo]>(value: [])
        var sections: BehaviorRelay<[CollectionDetailsSection]> = BehaviorRelay<[CollectionDetailsSection]>(value: [])
    }
    public var output: Output = Output()
    
    // MARK: - Private
    private var nextLoadPage: Int = 1
    private var currentPhotos: [Photo] = []
    private var emptyPhotos: [Photo] = Array(repeating: Photo(), count: 10)
    
    // MARK: - Inject
    override func inject(args: [String : Any?]?) {
        if let collection = args?["collection"]{
            self.input.collection = BehaviorRelay(value: collection as? Collection)
        }
    }
    
    // MARK: - Bind
    override func bind() {
        
        // Service
        let collectionService = self.service(type: CollectionService.self)!
        
        // Binding
        // LoadMore.
        self.input.loadMoreAction = Action<Void, [Photo]>(workFactory: { [weak self] _ -> Observable<[Photo]> in
            guard let self = self else { return Observable.empty() }
            
            self.output.loadingMore.accept(true)
            
            // Before the request returns.
            self.output.photos.accept(self.currentPhotos + self.emptyPhotos)
            
            if let id = self.input.collection.value?.id{
                return collectionService.getCollectionPhotos(id: id, page: self.nextLoadPage, perPage: 20)
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
        
        // Sections.
        self.output.photos
            .subscribe(onNext: { [weak self] (photos) in
                guard let self = self else { return }
                
                self.output.sections.accept([
                    CollectionDetailsSection(header: self.input.collection.value, items: photos)
                ])
            })
            .disposed(by: self.disposeBag)
        
    }
    
}
