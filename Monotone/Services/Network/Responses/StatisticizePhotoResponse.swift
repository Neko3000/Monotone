//
//  StatisticizePhotoResponse.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/02.
//

import Foundation
import ObjectMapper

class StatisticizePhotoResponse: BaseResponse{
    public var id: String?
    public var statistics: Statistics?
    
    override func mapping(map: Map) {
        id <- map["id"]
        statistics = Statistics(map: map)
    }
}
