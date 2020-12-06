//
//  Links.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/10.
//

import Foundation
import ObjectMapper

class Links: Mappable{
    public var selfLink: String?
    public var html: String?
    public var photos: String?
    public var likes: String?
    public var download: String?
    public var downloadLocation: String?
    
    init() {
        
    }

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        selfLink           <- map["self"]
        html               <- map["html"]
        photos             <- map["photos"]
        likes              <- map["likes"]
        download           <- map["download"]
        downloadLocation   <- map["download_location"]

    }
    
}
