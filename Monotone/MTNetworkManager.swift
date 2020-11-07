//
//  MTNetworkManager.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/10/31.
//

import Foundation

import Alamofire
import SwiftyJSON

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
            "Authorization" : "Client-ID \(self.secretKey)"
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
    
    public func request(request:MTBaseRequest, method:HTTPMethod, success:@escaping (JSON)->Void, fail:@escaping (JSON)->Void){
        
        let url = self.domain + request.api!
            
        AF.request(url, method: method, parameters: request.json, headers: self.headers)
            .response{ (response) in
                
            switch(response.result){
            case .success(let data):
                
                if(response.response?.statusCode == 200){
                    do{
                        let json = try JSON(data: data!)
                        success(json)
                    }
                    catch{
                        print("Could not decode success result from \(url)")
                    }
                    
                }
                else{
                    do{
                        let json = try JSON(data: data!)
                        fail(json)
                    }
                    catch{
                        print("Could not decode failure errors from \(url)")
                    }

                }
                break
            
            case .failure(let error):
                print("\(error.localizedDescription)")
                break
                
            }
        }
    }
}
