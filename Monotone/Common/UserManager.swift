//
//  UserManager.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/23.
//

import Foundation
import RxSwift

class UserManager{
    public static let shared = UserManager(userService: UserService())
    
    // MARK: - Public
    public var currentUser : User?{
        get{
            return _currentUser
        }
    }

    init(userService: UserService){
        self.userService = userService
        self.updateCurrentUser()
    }
    
    // MARK: - Private
    private let userService: UserService
    private var _currentUser: User?
    private let disposeBag: DisposeBag = DisposeBag()
    
    
    // MARK: - UpdateCurrentUser
    public func updateCurrentUser(){
        userService.getMineProfile()
            .subscribe(onNext: { [weak self] (user) in
                guard let self = self else { return }
                
                self._currentUser = user
            })
            .disposed(by: self.disposeBag)
    }
}
