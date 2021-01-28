//
//  AuthService.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/8.
//

import Foundation

import ObjectMapper
import RxSwift

// MARK: - AuthService
class AuthService: BaseService {
    
    public func authorize() -> Observable<String>{
        
        return AuthManager.shared.authorize()
    }
    
    public func token(code: String) -> Observable<String>{
        
        return AuthManager.shared.token(code: code)
    }
}
