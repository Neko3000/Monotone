//
//  AppCredential.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/9.
//

import Foundation
import SwiftyJSON

let debugKeyFileName: String = "api_keys_debug"
let sampleKeyFileName: String = "api_keys_sample"

class AppCredential{
    
    init(){
        
        // Load API keys.
        var keyFilePath: String? = nil
        keyFilePath = Bundle.main.path(forResource: sampleKeyFileName, ofType: "json") ?? keyFilePath
        keyFilePath = Bundle.main.path(forResource: debugKeyFileName, ofType: "json") ?? keyFilePath
        
        if(keyFilePath == nil){
            fatalError("API key file does not exist.")
        }
        
        do{
            let data = try Data(contentsOf: URL(fileURLWithPath: keyFilePath!))
            let json = try JSON(data: data)
            
            self._accessKey = json["api_keys"]["access_key"].stringValue
            self._secretKey = json["api_keys"]["secret_key"].stringValue
            
        }
        catch{
            fatalError("Could not read json format for API key file.")
        }
        
    }
    
    // MARK: Public
    public var accessKey : String{
        get{ return _accessKey }
    }
    
    public var secretKey : String{
        get{ return _secretKey }
    }
    
    // MARK: Private
    private var _accessKey : String
    private var _secretKey : String
}
