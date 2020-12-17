//
//  AuthManager.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/8.
//

import Foundation
import AuthenticationServices

import Alamofire
import SwiftyJSON
import RxSwift
import RxRelay

// MARK: AuthManager
class AuthManager: NSObject{
    
    // MARK: - Single Skeleton
    static let shared = AuthManager()
    
    override init(){
        super.init()
        
    }
    
    // MARK: Public
    public let domain: String = "https://unsplash.com/oauth/"
    
    public var credential: AuthCredential?{
        get{
            return AuthCredential.localCredential()
        }
        set{
            _credential = newValue
            AuthCredential.storeCredential(for: _credential!)
        }
    }
    
    // MARK: Private
    private var _credential: AuthCredential?
    private var authSession: ASWebAuthenticationSession!
    
    // MARK: Authroize
    public func authorize() -> Observable<String>{
        
        let params = [
            URLQueryItem(name: "client_id", value: AppManager.shared.credntial.accessKey),
            URLQueryItem(name: "redirect_uri", value: AuthArguments.redirectUri),
            URLQueryItem(name: "response_type", value: AuthArguments.responseType),
            URLQueryItem(name: "scope", value: AuthArguments.scope),
        ]
     
        var urlComponents = URLComponents(string: self.domain + "authorize")!
        urlComponents.queryItems = params
        
        return Observable.create { (observer) -> Disposable in
            
            let authSession = ASWebAuthenticationSession(url: urlComponents.url!, callbackURLScheme: UrlScheme.main){ (callbackURL, error) in
                
                guard error == nil, let callbackURL = callbackURL else {
                    observer.onCompleted()
                    return
                }
                
                guard let code = callbackURL.value(of: "code") else {
                    observer.onCompleted()
                    return
                }
                
                observer.onNext(code)
                observer.onCompleted()
            }
            
            if #available(iOS 13.0, *) {
                authSession.presentationContextProvider = self
            }
            
            authSession.prefersEphemeralWebBrowserSession = true
            authSession.start()
            
            return Disposables.create()
        }
    }
    
    // MARK: Token
    public func token(code: String) -> Observable<String>{
        
        let params = [
            "client_id" : AppManager.shared.credntial.accessKey,
            "client_secret": AppManager.shared.credntial.secretKey,
            "redirect_uri": AuthArguments.redirectUri,
            "code": code,
            "grant_type": AuthArguments.grandType,
        ]
    
        let url = self.domain + "token"
        
        return Observable.create { (observer) -> Disposable in
            let request = AF.request(url, method: .post, parameters: params)
                .response{ (response) in
                    
                switch(response.result){
                case .success(let data):

                    if(response.response?.statusCode == 200){
                        do{
                            let json = try JSON(data: data!)
                            
                            let accessToken = json["access_token"].stringValue
                            let tokenType = json["token_type"].stringValue
                            let scope = json["scope"].stringValue
                            let createdAt = json["created_at"].doubleValue
                            
                            self.credential = AuthCredential(accessToken: accessToken, tokenType: tokenType, scope: scope, createdAt: createdAt)
                            observer.onNext(accessToken)
                        }
                        catch{
                            print("Could not decode success result from \(url), the error is \(error.localizedDescription)")
                        }
                    }
                    else{
                        do{
                            let json = try JSON(data: data!)
                            
                            let title = json["error"].string ?? ""
                            let description = json["error_description"].string ?? ""
                            
                            let error = AuthError(title: title, description: description)
                            
                            MessageCenter.shared.showMessage(title: title, body: description, theme: .error)
                            observer.onError(error)
                        }
                        catch{
                            print("Could not decode failure errors from \(url), the error is \(error.localizedDescription)")

                            MessageCenter.shared.showMessage(title: NSLocalizedString("unsplash_auth_error_title",
                                                                                      comment: "Oops, there was a problem of authentication..."),
                                                             body: error.localizedDescription,
                                                             theme: .error)
                        }
                    }
                    
                    observer.onCompleted()
                    break
                
                case .failure(let error):
                    
                    print("\(error.localizedDescription)")
                    
                    MessageCenter.shared.showMessage(title: NSLocalizedString("unsplash_auth_error_title",
                                                                              comment: "Oops, there was a problem of authentication..."),
                                                     body: error.localizedDescription,
                                                     theme: .error)
                    observer.onError(error)
                    break
                }
            }
            
            return Disposables.create {
                request.cancel()
            }
        }

    }

}

// MARK: ASWebAuthenticationPresentationContextProviding
extension AuthManager: ASWebAuthenticationPresentationContextProviding{
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
}

