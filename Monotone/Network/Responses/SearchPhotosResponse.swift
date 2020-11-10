//
//  SearchPhotosResponse.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/8.
//

import Foundation
import ObjectMapper

class SearchPhotosResponse: BaseResponse, Mappable{
    public var total: Int?
    public var totalPages: Int?
    public var results: [Photo]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.total      <- map["total"]
        self.totalPages <- map["total_pages"]
        self.results    <- map["results"]
    }
}
