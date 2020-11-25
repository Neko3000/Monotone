//
//  NetworkManager.swift
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

class NetworkManager{
    static let shared = NetworkManager()
    
    init() {
        // Load API keys
        self.loadAPIKeys()
    }
    
    let domain: String = "https://api.unsplash.com/"
    
    // MARK: API keys
    public var accessKey : String{
        get{ return _accessKey ?? "" }
    }
    
    public var secretKey : String{
        get{ return _secretKey ?? "" }
    }
    
    private var _accessKey : String?
    private var _secretKey : String?
    
    // MARK: Header
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
    
    public func request(request:BaseRequest, method:HTTPMethod) -> Observable<[String: Any]>{
        
        let url = self.domain + (request.api ?? "")
        
        return Observable.create { (observer) -> Disposable in
            let request = AF.request(url, method: method, parameters: request.toJSON(), headers: self.headers)
                .response{ (response) in
                    
                switch(response.result){
                case .success(let data):

                    if(response.response?.statusCode == 200){
                        do{
                            var json = try JSON(data: data!)
                        
                            // If the json is a root array without any keys, put the root array into result key.
                            if(json.arrayObject != nil){
                                json = JSON(["results": json.arrayObject])
                            }
                            
                            observer.onNext(json.dictionaryObject ?? [String :Any]())
                        }
                        catch{
                            print("Could not decode success result from \(url), the error is \(error.localizedDescription)")
                        }
                    }
                    else{
                        do{
                            let json = try JSON(data: data!)
                            let error = NetworkError(errorStrs: json["errors"].arrayObject as! [String])
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
