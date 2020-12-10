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
    static let shared = AuthManager()
    
    override init(){
        super.init()
        
        //
        self.credential = AuthCredential.localCredential()
    }
    
    // MARK: Public
    public let domain: String = "https://unsplash.com/oauth/"
    
    public var accessToken: String{
        get { return _accessToken ?? "" }
    }
    
    public var credential: AuthCredential?{
        didSet(credential){
            if let credential = credential{
                // Presistence.
                AuthCredential.storeCredential(for: credential)
            }
        }
    }
    
    // MARK: Private
    private var _accessToken: String?
    private var authSession: ASWebAuthenticationSession!
    
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
            
            self.authSession = ASWebAuthenticationSession(url: urlComponents.url!, callbackURLScheme: UrlScheme.main){ (callbackURL, error) in
                guard error == nil, let callbackURL = callbackURL else { return }
                guard let code = callbackURL.value(of: "code") else { return }
                
                observer.onNext(code)
            }
            
            if #available(iOS 13.0, *) {
                self.authSession.presentationContextProvider = self
            }
            
            self.authSession.start()
            
            return Disposables.create()
        }
    }
    
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
                            let createAt = json["create_at"].doubleValue
                            
                            self.credential = AuthCredential(accessToken: accessToken, tokenType: tokenType, scope: scope, createAt: createAt)
                            
                            observer.onNext(json["access_token"].stringValue)
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
                            observer.onError(error)
                        }
                        catch{
                            print("Could not decode failure errors from \(url), the error is \(error.localizedDescription)")
                        }
                    }
                    
                    observer.onCompleted()
                    break
                
                case .failure(let error):
                    
                    print("\(error.localizedDescription)")
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

