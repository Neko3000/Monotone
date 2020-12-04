//
//  Historical.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/02.
//

import Foundation
import ObjectMapper

class Historical: Mappable {

    var change: Int?
    var resolution: String?
    var quantity: Int?
    var values: [HistoricalValue]?
    
    init() {
        
    }

    required init?(map: Map) {
        
    }

    func mapping(map: Map) {
        change      <- map["change"]
        resolution  <- map["resolution"]
        quantity    <- map["quantity"]
        values      <- map["values"]
    }
}
