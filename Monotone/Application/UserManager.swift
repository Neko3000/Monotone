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
    
    // MARK: - UpdateCurrentUser
    @discardableResult
    public func updateCurrentUser() -> Observable<Void>{
        
        /*
        return self.userService.getMineProfile()
            .flatMap { (user) -> Observable<Void> in
                
                return Observable.just(Void())
            }
         */
        
        return Observable.create { [weak self](observer) -> Disposable in
            guard let self = self else { return Disposables.create() }

            return self.userService.getMineProfile()
                .subscribe(onNext: { [weak self] (user) in
                    guard let self = self else { return }
 
                    self.currentUser.accept(user)
                    
                    observer.onCompleted()

                }, onError: { (error) in

                    observer.onError(error)
                })
        }
    }
}
