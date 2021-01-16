//
//  PhotoCreateCollectionViewModel.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/7.
//

import Foundation

import RxSwift
import RxRelay
import Action

class PhotoCreateCollectionViewModel: BaseViewModel, ViewModelStreamable{
    
    // MARK: - Input
    struct Input {
        var title: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
        var description: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
        var isPrivate: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
        var submitAction: Action<Void, Collection?>?
    }
    public var input: Input = Input()
    
    // MARK: - Output
    struct Output {
        var collection: BehaviorRelay<Collection?> = BehaviorRelay<Collection?>(value: nil)
    }
    public var output: Output = Output()
    
    // MARK: - Private
    //
    
    // MARK: - Inject
    override func inject(args: [String : Any?]?) {

    }
    
    // MARK: - Bind
    override func bind() {
        
        // Service.
        let collectionService = self.service(type: CollectionService.self)!
        
        // Bindings.
        self.input.submitAction = Action<Void,Collection?>(workFactory: { _ -> Observable<Collection?> in
            return collectionService.createCollection(title: self.input.title.value,
                                                      description: self.input.description.value,
                                                      isPrivate: self.input.isPrivate.value)
        })
        
        self.input.submitAction?.elements
            .subscribe(onNext: { [weak self] (collection) in
                guard let self = self else { return }

                self.output.collection.accept(collection)
            })
            .disposed(by: self.disposeBag)
        
        self.input.submitAction?.errors
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }

                self.output.collection.accept(nil)
            })
            .disposed(by: self.disposeBag)
        
    }
    
}
