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
        var loginAction: Action<Void,URL?>?
    }
    public var input: Input = Input()
    
    // MARK: - Output
    struct Output {
        //
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
        self.input.loginAction = Action<Void, URL?>(workFactory: { (_) -> Observable<URL?> in
            
            return authService.authorize()
        })
        
        self.input.loginAction?.elements
            .filter({ $0 != nil })
            .subscribe(onNext: { url in
                print(url!.absoluteString)
            
        })
            .disposed(by: self.disposeBag)
    }
    
}
