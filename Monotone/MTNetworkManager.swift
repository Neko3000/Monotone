//
//  MTNetworkManager.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/10/31.
//

import Foundation

import Alamofire
import SwiftyJSON
import RxSwift

let debugKeyFileName: String = "api_keys_debug"
let sampleKeyFileName: String = "api_keys_sample"

class MTNetworkManager{
    static let shared = MTNetworkManager()
    
    init() {
        // Load API keys
        self.loadAPIKeys()
    }
    
    let domain: String = "https://api.unsplash.com/"
    
    /// API keys
    public var accessKey : String{
        get{ return _accessKey ?? "" }
    }
    
    public var secretKey : String{
        get{ return _secretKey ?? "" }
    }
    
    private var _accessKey : String?
    private var _secretKey : String?
    
    /// Header
    private var headers : HTTPHeaders{
        get{ return [
            "Authorization" : "Client-ID \(self.accessKey)"
        ] }
    }
    
    
    private func loadAPIKeys(){
        
        var keyFilePath: String? = nil
        keyFilePath = Bundle.main.path(forResource: sampleKeyFileName, ofType: "json") ?? keyFilePath
        keyFilePath = Bundle.main.path(forResource: debugKeyFileName, ofType: "json") ?? keyFilePath
        
        if(keyFilePath == nil){
            fatalError("API key file does not exist.")
        }
        
        do{
            let data = try Data(contentsOf: URL(fileURLWithPath: keyFilePath!))
            let json = try JSON(data: data)
            
            self._accessKey = json["api_keys"]["access_key"].string
            self._secretKey = json["api_keys"]["secret_key"].string
            
        }
        catch{
            fatalError("Could not read json format for API key file.")
        }

    }
    
    public func request(request:MTBaseRequest, method:HTTPMethod) -> Observable<[String: Any]>{
        
        let url = self.domain + request.api!
        
        return Observable.create { (observer) -> Disposable in
            AF.request(url, method: method, parameters: request.toParams(), headers: self.headers)
                .response{ (response) in
                    
                switch(response.result){
                case .success(let data):
                    
                    if(response.response?.statusCode == 200){
                        do{
                            let json = try JSON(data: data!)
                            observer.onNext(json.dictionaryObject!)
                        }
                        catch{
                            print("Could not decode success result from \(url)")
                        }
                        
                    }
                    else{
                        do{
                            let json = try JSON(data: data!)
                            let error = UnsplashNetworkError(errorStrs: json.arrayObject as! [String])
                            observer.onError(error)
                        }
                        catch{
                            print("Could not decode failure errors from \(url)")
                        }

                    }
                    break
                
                case .failure(let error):
                    print("\(error.localizedDescription)")
                    observer.onError(error)
                    break
                }
            }
            
            return Disposables.create()
        }
    }
}
