//
//  UserManager.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/23.
//

import Foundation

import RxSwift
import RxRelay

class UserManager{
    // MARK: - Single Skeleton
    public static let shared = UserManager(userService: UserService())
    
    // MARK: - Public
    public let currentUser: BehaviorRelay<User?> = BehaviorRelay<User?>(value: nil)

    init(userService: UserService){
        self.userService = userService
    }
    
    // MARK: - Private
    private let userService: UserService
    private let disposeBag: DisposeBag = DisposeBag()

    //
}
