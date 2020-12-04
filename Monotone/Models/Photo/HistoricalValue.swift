//
//  HistoricalValue.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/02.
//

import Foundation
import ObjectMapper

class HistoricalValue: Mappable {

    var date: Date?
    var value: Int?
    
    init() {
        
    }

    required init?(map: Map) {
        
    }

    func mapping(map: Map) {
        date    <- (map["date"], ISO8601DateTransform())
        value   <- map["value"]
    }
}
