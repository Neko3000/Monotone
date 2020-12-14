//
//  NetworkManager.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/10/31.
//

import Foundation

import SwiftyJSON
import Alamofire
import RxSwift

class NetworkManager{
    static let shared = NetworkManager()
    
    init() {
        //
    }
    
    let domain: String = "https://api.unsplash.com/"
    
    // MARK: Headers
    private var headers : HTTPHeaders{
        get{
            var tokenType: String = ""
            var accessToken: String = ""
            
            if(AuthManager.shared.credential != nil){
                tokenType = AuthManager.shared.credential!.tokenType
                accessToken = AuthManager.shared.credential!.accessToken
            }
            else{
                tokenType = "Client-ID"
                accessToken = AppManager.shared.credntial.accessKey
            }
            
            return [
                "Authorization" : "\(tokenType) \(accessToken)"
            ]
        }
    }
    
    // MARK: Request.
    public func request(request:BaseRequest, method:HTTPMethod) -> Observable<[String: Any]>{
        
        let endPoint = (request.api ?? "").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = self.domain + (endPoint ?? "")
        
        return Observable.create { (observer) -> Disposable in
            let request = AF.request(url, method: method, parameters: request.toJSON(), headers: self.headers)
                .response{ (response) in
                    
                switch(response.result){
                case .success(let data):

                    if(response.response?.statusCode == 200 || response.response?.statusCode == 201){
                        do{
                            var json = try JSON(data: data!)
                        
                            // If the json is a root array without any keys, put the root array into result key.
                            if(json.arrayObject != nil){
                                json = JSON(["results": json.arrayObject])
                            }
                            
                            observer.onNext(json.dictionaryObject ?? [String :Any]())
                            observer.onCompleted()
                        }
                        catch{
                            print("Could not decode success result from \(url), the error is \(error.localizedDescription)")
                            
                            observer.onCompleted()
                        }
                    }
                    else{
                        do{
                            let json = try JSON(data: data!)
                            let error = NetworkError(errorStrs: json["errors"].arrayObject as! [String])
                            
                            MessageCenter.shared.showMessage(title: NSLocalizedString("unsplash_network_error_title",
                                                                                      comment: "Oops, there was a problem on network..."),
                                                             body: error.localizedDescription,
                                                             theme: .error)
                            
                            observer.onError(error)
                        }
                        catch{
                            print("Could not decode failure errors from \(url), the error is \(error.localizedDescription)")
                            
                            observer.onError(error)
                        }
                    }
                    
                    break
                
                case .failure(let error):
                    
                    print("\(error.localizedDescription)")
                    
                    MessageCenter.shared.showMessage(title: NSLocalizedString("unsplash_network_error_title",
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
