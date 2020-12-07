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
    }
    public var input: Input = Input()
    
    // MARK: - Output
    struct Output {
        var collections: BehaviorRelay<[Collection]> = BehaviorRelay<[Collection]>(value: [])
    }
    public var output: Output = Output()
    
    // MARK: - Private

    
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
        self.input.username.flatMap { (username) -> Observable<[Collection]> in
            return userService.listUserCollections(username: username)
        }
        .subscribe(onNext: { (collections) in
            
            self.output.collections.accept(collections)
        }, onError: { (error) in
            
        })
        .disposed(by: self.disposeBag)
        
    }
    
}
