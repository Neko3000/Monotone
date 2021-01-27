//
//  SearchCollectionsResponse.swift
//  Monotone
//
//  Created by Xueliang Chen on 2021/1/27.
//

import Foundation
import ObjectMapper

class SearchCollectionsResponse: BaseResponse{
    public var total: Int?
    public var totalPages: Int?
    public var results: [Collection]?
    
    override func mapping(map: Map) {
        total      <- map["total"]
        totalPages <- map["total_pages"]
        results    <- map["results"]
    }
}
