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
        var pages: BehaviorRelay<[(key:SideMenuPage, value:String)]?> = BehaviorRelay<[(key:SideMenuPage, value:String)]?>(value: nil)
        var currentUser: BehaviorRelay<User?> = BehaviorRelay<User?>(value: nil)
    }
    public var input: Input = Input()
    
    // MARK: - Output
    struct Output {
        var pages: BehaviorRelay<[(key:SideMenuPage, value:String)]?> = BehaviorRelay<[(key:SideMenuPage, value:String)]?>(value: nil)
        var currentUser: BehaviorRelay<User?> = BehaviorRelay<User?>(value: nil)
        
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
        // CurrentUser.
        self.input.currentUser
            .bind(to: self.output.currentUser)
            .disposed(by: self.disposeBag)
        
        // Pages.
        self.input.pages
            .subscribe { (keyValuePairs) in
                self.output.pages.accept(keyValuePairs)
            }
            .disposed(by: self.disposeBag)
        
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
