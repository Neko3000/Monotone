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
        var loginAction: Action<Void,String>!
    }
    public var input: Input = Input()
    
    // MARK: - Output
    struct Output {
        var loggedIn: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
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
        self.input.loginAction = Action<Void, String>(workFactory: { (_) -> Observable<String> in
            
            return authService.authorize()
        })
        
        self.input.loginAction?.elements
            .flatMap({ (code) -> Observable<String> in
                return authService.token(code: code)
            })
            .subscribe(onNext: { token in
                
                self.output.loggedIn.accept(true)
            }, onError: { (error) in
                
                self.output.loggedIn.accept(false)
            })
            .disposed(by: self.disposeBag)
    }
    
}
