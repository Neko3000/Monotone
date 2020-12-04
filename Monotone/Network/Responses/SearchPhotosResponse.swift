//
//  SearchPhotosResponse.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/8.
//

import Foundation
import ObjectMapper

class SearchPhotosResponse: BaseResponse{
    public var total: Int?
    public var totalPages: Int?
    public var results: [Photo]?
    
    override func mapping(map: Map) {
        total      <- map["total"]
        totalPages <- map["total_pages"]
        results    <- map["results"]
    }
}
