//
//  Exif.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/18.
//

import Foundation
import ObjectMapper

class Exif: Mappable {

    var iso: String?
    var aperture: String?
    var model: String?
    var focalLength: String?
    var exposureTime: String?
    var make: String?
    
    init() {
        
    }

    required init?(map: Map) {
        
    }

    func mapping(map: Map) {
        iso             <- map["iso"]
        aperture        <- map["aperture"]
        model           <- map["model"]
        focalLength     <- map["focal_length"]
        exposureTime    <- map["exposure_time"]
        make            <- map["make"]
    }
}
