//
//  ListUserPhotosResponse.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/7.
//

import Foundation
import ObjectMapper

class ListUserPhotosResponse: BaseResponse{
    public var results: [Photo]?
    
    override func mapping(map: Map) {
        results <- map["results"]
    }
}
