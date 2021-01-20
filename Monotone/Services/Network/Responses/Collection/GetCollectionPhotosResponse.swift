//
//  GetCollectionPhotosResponse.swift
//  Monotone
//
//  Created by Xueliang Chen on 2021/1/21.
//

import Foundation
import ObjectMapper

class GetCollectionPhotosResponse: BaseResponse{
    public var results: [Photo]?

    override func mapping(map: Map) {
        results <- map["results"]
    }
}
