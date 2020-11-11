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
        self.total      <- map["total"]
        self.totalPages <- map["total_pages"]
        self.results    <- map["results"]
    }
}
