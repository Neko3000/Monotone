//
//  StatisticizeUserResponse.swift
//  Monotone
//
//  Created by Xueliang Chen on 2021/1/31.
//

import Foundation
import ObjectMapper

class StatisticizeUserResponse: BaseResponse{
    public var username: String?
    public var statistics: Statistics?
    
    override func mapping(map: Map) {
        username <- map["username"]
        statistics = Statistics(map: map)
    }
}
