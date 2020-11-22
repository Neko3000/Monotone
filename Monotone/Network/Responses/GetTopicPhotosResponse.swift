//
//  GetTopicPhotosResponse.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/22.
//

import Foundation
import ObjectMapper

class GetTopicPhotosResponse: BaseResponse{
    public var results: [Photo]?
    
    override func mapping(map: Map) {
        self.results <- map["results"]
    }
}
