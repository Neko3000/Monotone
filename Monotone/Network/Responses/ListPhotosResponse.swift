//
//  ListPhotosResponse.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/11.
//

import Foundation
import ObjectMapper

class ListPhotosResponse: BaseResponse{
    public var results: [Photo]?
    
    override func mapping(map: Map) {
        self.results <- map["results"]
    }
}
