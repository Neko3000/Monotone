//
//  ListCollectionsResponse.swift
//  Monotone
//
//  Created by Xueliang Chen on 2021/1/18.
//

import Foundation
import ObjectMapper

class ListCollectionsResponse: BaseResponse{
    public var results: [Collection]?

    override func mapping(map: Map) {
        results <- map["results"]
    }
}
