//
//  MTNetworkManager.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/10/31.
//

import Foundation

let debugKeyFileName: String = "api_keys_debug"
let sampleKeyFileName: String = "api_keys_sample"

class MTNetworkManager : NSObject{
    static let shared = MTNetworkManager()
    
    private var accessKey : String?
    private var secretKey : String?
    
    override init() {
        super.init()
        
        // 
        self.loadAPIKeys()
    }
    
    public func loadAPIKeys(){
        
        var keyFilePath: String? = nil
        keyFilePath = Bundle.main.path(forResource: sampleKeyFileName, ofType: "json") ?? keyFilePath
        keyFilePath = Bundle.main.path(forResource: debugKeyFileName, ofType: "json") ?? keyFilePath
        
        if(keyFilePath == nil){
            fatalError("Api key file does not exist.")
        }
        
        do{
            let data = try Data(contentsOf: URL(fileURLWithPath: keyFilePath!))
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
            
            let apiKeys = json!["api_keys"] as? [String : Any]
            self.accessKey = apiKeys!["access_key"] as? String
            self.secretKey = apiKeys!["secret_key"] as? String
            
        }
        catch{
            fatalError("Can not read json file.")
        }

    }
}
