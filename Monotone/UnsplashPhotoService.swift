//
//  UnsplashPhotoService.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/7.
//

import Foundation
import ObjectMapper

class UnsplashPhotoService: NetworkServiceProtocol{
    static func searchPhotos(query:String,
                      page:Int? = 1,
                      perPage:Int? = 10,
                      orderBy:String? = "relevant",
                      collections:[String]? = [],
                      contentFilter:String? = "low",
                      color:String? = "",
                      oritentation:String? = ""){
        
        let request: SearchPhotosRequest = SearchPhotosRequest()
        request.query = "penguin"

        MTNetworkManager.shared.request(request: request, method: .get) { (json) in
            print(json)
        } fail: { (json) in
            print(json)
        }

        
    }
}
