//
//  AppCredential.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/9.
//

import Foundation
import SwiftyJSON

class AppCredential{
    
    let configDebugFileName: String = "config_debug"
    let configFileName: String = "config"
    
    init(){
        
        // Load Config.
        var configFilePath: String? = nil
        configFilePath = Bundle.main.path(forResource: configDebugFileName, ofType: "json") ?? configFilePath
        configFilePath = Bundle.main.path(forResource: configFileName, ofType: "json") ?? configFilePath
        
        if(configFilePath == nil){
            fatalError("Config file does not exist.")
        }
        
        do{
            let data = try Data(contentsOf: URL(fileURLWithPath: configFilePath!))
            let json = try JSON(data: data)
            
            self._accessKey = json["api_keys"]["access_key"].stringValue
            self._secretKey = json["api_keys"]["secret_key"].stringValue
            
        }
        catch{
            fatalError("Could not read json format for config file.")
        }
        
    }
    
    // MARK: - Public
    public var accessKey : String{
        get{ return _accessKey }
    }
    
    public var secretKey : String{
        get{ return _secretKey }
    }
    
    // MARK: - Private
    private var _accessKey : String
    private var _secretKey : String
}
