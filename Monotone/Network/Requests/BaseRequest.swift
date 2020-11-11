//
//  BaseRequest.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/1.
//

import Foundation
import ObjectMapper

protocol BaseRequestProtocol {
    var api : String? { get }
}

class BaseRequest : Mappable, BaseRequestProtocol{
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
