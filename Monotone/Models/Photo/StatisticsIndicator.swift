//
//  StatisticsIndicator.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/02.
//

import Foundation
import ObjectMapper

class StatisticsIndicator: Mappable {

    public var total: Int?
    public var historical: Historical?
    
    init() {
        
    }

    required init?(map: Map) {
        self.mapping(map: map)
    }

    func mapping(map: Map) {
        total       <- map["total"]
        historical  <- map["historical"]
    }
}
