//
//  CollectionsViewModel.swift
//  Monotone
//
//  Created by Xueliang Chen on 2021/1/18.
//

import Foundation

import RxSwift
import RxRelay
import Action

class CollectionsViewModel: BaseViewModel, ViewModelStreamable{
    
    // MARK: - Input
    struct Input {
        var loadMoreAction: Action<Void, [Collection]>?
        var reloadAction: Action<Void, [Collection]>?
    }
    public var input: Input = Input()
    
    // MARK: - Output
    struct Output {
        var collections: BehaviorRelay<[Collection]> = BehaviorRelay<[Collection]>(value: [])
        var loadingMore: PublishRelay<Bool> = PublishRelay<Bool>()
        var reloading: PublishRelay<Bool> = PublishRelay<Bool>()
    }
    public var output: Output = Output()
    
    // MARK: - Private
    private var currentCollections: [Collection] = []
    private var nextLoadPage: Int = 1
    
    // MARK: - Inject
    override func inject(args: [String : Any?]?) {
        //
    }
    
    // MARK: - Bind
    override func bind() {
        
        // Service.
        let collectionService = self.service(type: CollectionService.self)!
        
        // Bindings.
        // LoadMore.
        self.input.loadMoreAction = Action<Void, [Collection]>(workFactory: { (_) -> Observable<[Collection]> in
            self.output.loadingMore.accept(true)
                        
            return collectionService.listCollections(page: self.nextLoadPage, perPage: 20)
        })
        
        self.input.loadMoreAction?.elements
            .subscribe(onNext: { [weak self] (collections: [Collection]) in
                guard let self = self else { return }
                
                self.currentCollections = self.nextLoadPage == 1 ? collections : self.currentCollections + collections
                self.nextLoadPage += 1
                
                self.output.collections.accept(self.currentCollections)
                
                self.output.loadingMore.accept(false)
            })
            .disposed(by: self.disposeBag)
        
        self.input.loadMoreAction?.errors
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                
                self.output.loadingMore.accept(false)
            })
            .disposed(by: self.disposeBag)
        
        // Reload.
        self.input.reloadAction = Action<Void, [Collection]>(workFactory: { [weak self] _ -> Observable<[Collection]> in
            guard let self = self else { return Observable.empty() }
            
            if let loadMoreAction = self.input.loadMoreAction{
                self.output.reloading.accept(true)
                self.nextLoadPage = 1
                
                return loadMoreAction.execute()
            }

            return Observable.empty()
        })
        
        self.input.reloadAction?.elements
            .subscribe(onNext: { [weak self ] (collections) in
                guard let self = self else { return }
                
                self.output.collections.accept(collections)
                
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
