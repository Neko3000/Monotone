//
//  MTBaseRequest.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/1.
//

import Foundation
import ObjectMapper

protocol MJBaseRequestProtocol {
    var api : String? { get }
    func toParams() -> [String : Any]
}

class MTBaseRequest : Mappable, MJBaseRequestProtocol{
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
    
    public func toParams() -> [String : Any] {
        return Mapper().toJSON(self)
    }
}
