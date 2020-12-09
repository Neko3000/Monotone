//
//  AuthManager.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/8.
//

import Foundation
import AuthenticationServices

import RxSwift
import RxRelay

class AuthManager: NSObject{
    static let shared = AuthManager()
    
    override init(){
        
    }
    
    let domain: String = "https://unsplash.com/oauth/"
    
    let callbackURLScheme = "monotone://"
    let redirectUri: String = "monotone://unsplash"
    let responseType: String = "code"
    let scope: String = "read_user+write_user"
    let grandType: String = "authorization_code"
    
    // MARK: Public
    public var accessToken: String{
        get { return _accessToken ?? "" }
    }
    
    // MARK: Private
    private var _accessToken: String?
    
    public func authorize() -> Observable<URL?>{
        
        let params = [
            URLQueryItem(name: "client_id", value: AppManager.shared.accessKey),
            URLQueryItem(name: "redirect_uri", value: self.redirectUri),
            URLQueryItem(name: "response_type", value: self.responseType),
            URLQueryItem(name: "scope", value: self.scope),
        ]
     
        var urlComponents = URLComponents(string: self.domain + "authorize")!
        urlComponents.queryItems = params
        
        return Observable.create { (observer) -> Disposable in
            
            let authSession = ASWebAuthenticationSession(url: urlComponents.url!, callbackURLScheme: self.callbackURLScheme){ (callbackUrl, error) in
                
                observer.onNext(callbackUrl)
            }
            
            if #available(iOS 13.0, *) {
                authSession.presentationContextProvider = self
            }
            
            authSession.start()
            
            return Disposables.create()
        }
    }
}

extension AuthManager: ASWebAuthenticationPresentationContextProviding{
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
}
