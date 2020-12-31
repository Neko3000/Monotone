//
//  LoginViewModel.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/8.
//

import Foundation

import RxSwift
import RxRelay
import Action

class LoginViewModel: BaseViewModel, ViewModelStreamable{
    
    // MARK: - Input
    struct Input {
        var loginAction: Action<Void,String>?
        var updateUserAction: Action<Void, User>?
    }
    public var input: Input = Input()
    
    // MARK: - Output
    struct Output {
        var logging: PublishRelay<Bool> = PublishRelay<Bool>()
        var user: BehaviorRelay<User?> = BehaviorRelay<User?>(value: nil)
    }
    public var output: Output = Output()
    
    // MARK: - Private
    //
    
    // MARK: - Inject
    override func inject(args: [String : Any?]?) {
        //
    }
    
    // MARK: - Bind
    override func bind() {
        
        // Service.
        let authService = self.service(type: AuthService.self)!
        let userService = self.service(type: UserService.self)!
        
        // Bindings.
        // UpdateUserAction.
        self.input.updateUserAction = Action<Void, User>(workFactory: { [weak self] (_) -> Observable<User> in
            guard let self = self else { return Observable.empty() }

            self.output.logging.accept(true)
            
            return userService.getMineProfile()
        })
        
        self.input.updateUserAction?.elements
            .subscribe(onNext: { [weak self] (user) in
                guard let self = self else { return }
                
                self.output.user.accept(user)
                self.output.logging.accept(false)
            })
            .disposed(by: self.disposeBag)
        
        self.input.updateUserAction?.errors
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                
                self.output.logging.accept(false)
            })
            .disposed(by: self.disposeBag)
        
        // LoginAction.
        self.input.loginAction = Action<Void, String>(workFactory: { (_) -> Observable<String> in
            
            return authService.authorize()
        })
        
        self.input.loginAction?.elements
            .flatMap({ [weak self] (code) -> Observable<String> in
                guard let self = self else { return Observable.empty() }
                
                self.output.logging.accept(true)

                return authService.token(code: code)
            })
            .flatMap({ [weak self] (token) -> Observable<User> in
                guard let self = self else { return Observable.empty() }

                return self.input.updateUserAction!.execute()
            })
            .subscribe(onNext: { [weak self] (user) in
                guard let self = self else { return }
                
                self.output.logging.accept(false)
            }, onError: { [weak self] (error) in
                guard let self = self else { return }
                
                self.output.logging.accept(false)
            })
            .disposed(by: self.disposeBag)
    }
    
}
