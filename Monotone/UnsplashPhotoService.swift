//
//  UnsplashPhotoService.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/7.
//

import Foundation

class UnsplashPhotoService: NetworkServiceProtocol{
    func searchPhotos(query:String,
                      page:Int?,
                      perPage:Int?,
                      orderBy:String?,
                      collections:[String]?,
                      contentFilter:String?,
                      color:String?,
                      oritentation:String?){
        
        let request: SearchPhotosRequest = SearchPhotosRequest()
        request
        
        MTNetworkManager.shared.request(request: <#T##MTBaseRequest#>, method: <#T##MTHTTPMethod#>, success: <#T##(JSON) -> Void#>, fail: <#T##(JSON) -> Void#>)
        
    }
}
