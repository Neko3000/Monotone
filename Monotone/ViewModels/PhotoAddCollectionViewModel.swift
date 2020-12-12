//
//  PhotoAddCollectionViewModel.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/7.
//

import Foundation

import RxSwift
import RxRelay
import Action

class PhotoAddCollectionViewModel: BaseViewModel, ViewModelStreamable{
    
    // MARK: - Input
    struct Input {
        var username: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
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
    private var nextLoadPage: Int = 1
    
    // MARK: - Inject
    override func inject(args: [String : Any]?) {
        if(args?["username"] != nil){
            self.input.username = BehaviorRelay(value: args!["username"] as! String)
        }
    }
    
    // MARK: - Bind
    override func bind() {
        
        // Service.
        let userService = self.service(type: UserService.self)!
        
        // Bindings.
        // LoadMore.
        self.input.loadMoreAction = Action<Void, [Collection]>(workFactory: { (_) -> Observable<[Collection]> in
            self.output.loadingMore.accept(true)
                        
            return userService.listUserCollections(username: self.input.username.value, page: self.nextLoadPage, perPage: 20)
        })
        
        self.input.loadMoreAction?.elements
            .subscribe(onNext: { (collections: [Collection]) in
                                
                self.output.collections.accept(self.nextLoadPage == 1 ? collections : self.output.collections.value + collections)
                self.nextLoadPage += 1
                
                self.output.loadingMore.accept(false)
            }, onError: { (error) in
                
                self.output.loadingMore.accept(false)
            })
            .disposed(by: self.disposeBag)
        
        // Reload.
        self.input.reloadAction = Action<Void, [Collection]>(workFactory: { (_) -> Observable<[Collection]> in
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
        
    }
    
}
