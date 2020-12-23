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
        var updateUserAction: Action<Void, Void>?
    }
    public var input: Input = Input()
    
    // MARK: - Output
    struct Output {
        var logging: PublishRelay<Bool> = PublishRelay<Bool>()
        var loggedIn: PublishRelay<Bool> = PublishRelay<Bool>()
    }
    public var output: Output = Output()
    
    // MARK: - Private
    //
    
    // MARK: - Inject
    override func inject(args: [String : Any]?) {
        //
    }
    
    // MARK: - Bind
    override func bind() {
        
        // Service.
        let authService = self.service(type: AuthService.self)!
        
        // Bindings.
        // updateUserAction
        self.input.updateUserAction = Action<Void, Void>(workFactory: { [weak self] (_) -> Observable<Void> in
            guard let self = self else { return Observable.empty() }

            self.output.logging.accept(true)
            
            return UserManager.shared.updateCurrentUser()
        })
        
        self.input.updateUserAction?.completions
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                
                self.output.loggedIn.accept(true)
                self.output.logging.accept(false)
            })
            .disposed(by: self.disposeBag)
        
        self.input.updateUserAction?.errors
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                
                self.output.loggedIn.accept(false)
                self.output.logging.accept(false)
            })
            .disposed(by: self.disposeBag)
        
        // loginAction
        self.input.loginAction = Action<Void, String>(workFactory: { (_) -> Observable<String> in
            self.output.logging.accept(true)
            
            return authService.authorize()
        })
        
        self.input.loginAction?.elements
            .flatMap({ (code) -> Observable<String> in
                return authService.token(code: code)
            })
            .flatMap({ (token) -> Observable<Void> in
                return self.input.updateUserAction!.execute()
            })
            .subscribe(onError: { [weak self] (error) in
                guard let self = self else { return }
                
                self.output.logging.accept(false)
            }, onCompleted: { [weak self] in
                guard let self = self else { return }
                
                self.output.logging.accept(false)
            })
            .disposed(by: self.disposeBag)
    }
    
}
