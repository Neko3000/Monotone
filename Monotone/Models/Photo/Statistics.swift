//
//  Statistics.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/02.
//

import Foundation
import ObjectMapper

class Statistics: Mappable {

    public var downloads: StatisticsIndicator?
    public var views: StatisticsIndicator?
    public var likes: StatisticsIndicator?

    required init?(map: Map) {
        self.mapping(map: map)
    }

    func mapping(map: Map) {
        downloads   <- map["downloads"]
        views       <- map["views"]
        likes       <- map["likes"]
    }
}
