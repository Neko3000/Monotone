//
//  AuthService.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/8.
//

import Foundation
import AuthenticationServices

import ObjectMapper
import RxSwift

// MARK: AuthService
class AuthService: BaseService {
    
    public func authorize() -> Observable<URL?>{
        
        return AuthManager.shared.authorize()
    }
}
