//
//  SearchPhotosRequest.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/1.
//

import Foundation

class SearchPhotosRequest: MTBaseRequest {
        
    override var api: String?{
        get{
            return "photos/"
        }
    }
    
    public var query: String?
    public var page: Int?
    public var perPage: Int?
    public var orderBy: String?
    public var collections: [String]?
    public var contentFilter: String?
    public var color: String?
    public var oritentation: String?
    
    override var params: [String : Any]{
        get{
            if(self.query != nil){
                
            }
        }
    }
    
}
