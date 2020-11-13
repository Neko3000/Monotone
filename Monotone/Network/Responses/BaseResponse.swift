//
//  BaseResponse.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/1.
//

import Foundation
import ObjectMapper

protocol Responsible {
    // FIXME: to add.
}

class BaseResponse : Mappable, Responsible{
    init() {
        // Implemented by subclass
    }
    
    required init?(map: Map) {
        // Implemented by subclass
    }
    
    func mapping(map: Map) {
        // Implemented by subclass
    }
    
    
}


