//
//  BaseRequest.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/1.
//

import Foundation
import ObjectMapper

protocol Requestable {
    var api : String? { get }
}

class BaseRequest : Mappable, Requestable{
    init() {
        // Implemented by subclass
    }
    
    required init?(map: Map) {
        // Implemented by subclass
    }
    
    func mapping(map: Map) {
        // Implemented by subclass
    }
    
    var api: String? { get{ return "" } }
}
