//
//  MTPhotoRequest.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/1.
//

import Foundation

class MTPhotoRequest: MTBaseRequest {
        
    override var api: String?{
        get{
            return "photos/"
        }
    }
    
}
