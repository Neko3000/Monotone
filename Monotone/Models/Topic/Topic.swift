//
//  Topic.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/18.
//

import Foundation
import ObjectMapper

class Topic: Mappable{

    public var id: String?
    public var slug: String?
    public var title: String?
    public var description: String?
    public var publishedAt: Date?
    public var updatedAt: Date?
    public var startsAt: Date?
    public var endsAt: Date?
    public var featured: Bool?
    public var totalPhotos: Int?
    public var links: Links?
    public var status: String?
    public var owners: [User]?
//    public var currentUserContributions:[]?
//    public var totalCurrentUserSubmissions:[]?
    public var coverPhoto: Photo?
    public var previewPhotos: [PreviewPhoto]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id              <- map["id"]
        slug            <- map["slug"]
        title           <- map["title"]
        description     <- map["description"]
        publishedAt     <- map["published_at"]
        updatedAt       <- map["updated_at"]
        startsAt        <- map["starts_at"]
        endsAt          <- map["ends_at"]
        featured        <- map["featured"]
        totalPhotos     <- map["total_photos"]
        links           <- map["links"]
        status          <- map["status"]
        owners          <- map["owners"]
        coverPhoto      <- map["coverPhoto"]
        previewPhotos   <- map["previewPhotos"]
    }
    
}
