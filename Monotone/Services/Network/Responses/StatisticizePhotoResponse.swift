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
    public var downloads: StatisticsIndicator?
    public var views: StatisticsIndicator?
    public var likes: StatisticsIndicator?
    
    override func mapping(map: Map) {
        id          <- map["id"]
        downloads   <- map["downloads"]
        views       <- map["views"]
        likes       <- map["likes"]
    }
}
