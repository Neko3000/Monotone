//
//  SideMenuViewModel.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/21.
//

import Foundation

import RxSwift
import RxRelay
import Action

class SideMenuViewModel: BaseViewModel, ViewModelStreamable{
    
    // MARK: - Input
    struct Input {
        var pages: BehaviorRelay<[SideMenuPage]?> = BehaviorRelay<[SideMenuPage]?>(value: nil)
        var currentUser: BehaviorRelay<User?> = BehaviorRelay<User?>(value: nil)
    }
    public var input: Input = Input()
    
    // MARK: - Output
    struct Output {
        var collections: BehaviorRelay<[Collection]?> = BehaviorRelay<[Collection]?>(value: nil)
        var likedPhotos: BehaviorRelay<[Photo]?> = BehaviorRelay<[Photo]?>(value: nil)
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
        let userService = self.service(type: UserService.self)!
        
        // Bindings.
        // LikedPhotos.
        self.input.currentUser
            .unwrap()
            .flatMap { (user) -> Observable<[Photo]> in
                
                if let username = user.username{
                    return userService.listUserLikedPhotos(username: username, orderBy: "latest")
                }
                
                return Observable.empty()
            }
            .bind(to: self.output.likedPhotos)
            .disposed(by: self.disposeBag)
        
        // Collections.
        self.input.currentUser
            .unwrap()
            .flatMap { (user) -> Observable<[Collection]> in
                
                if let username = user.username{
                    return userService.listUserCollections(username: username)
                }
                
                return Observable.empty()
            }
            .bind(to: self.output.collections)
            .disposed(by: self.disposeBag)
        
    }
    
}
