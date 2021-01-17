//
//  WallpaperSize.swift
//  Monotone
//
//  Created by Xueliang Chen on 2021/1/16.
//

import UIKit

enum WallpaperSize{
    case all
    case iphone
    case android
    case mac
    case resolution4K
    case lock
    case ipad
}

extension WallpaperSize: RawRepresentable, CaseIterable{
    init?(rawValue: (key:String, title: String, aspectRatio: Double?, minSize: CGSize?, image: UIImage?)) {
        switch rawValue.key {
        
        case "all":
            self = .all
        
        case "iphone":
            self = .iphone
        
        case "android":
            self = .android
            
        case "mac":
            self = .mac
            
        case "resolution4K":
            self = .resolution4K
            
        case "lock":
            self = .lock
            
        case "ipad":
            self = .ipad
            
        default:
            return nil
        }
    }
    
    var rawValue: (key:String, title: String, aspectRatio: Double?, minSize: CGSize?, image: UIImage?) {
        switch self {
        
        case .all:
            return (key:"all",
                    title:"All Wallpapers",
                    aspectRatio: nil,
                    minSize: nil,
                    image: UIImage(named: "wallpaper-size-selection-all"))
        
        case .iphone:
            return (key:"iphone",
                    title:"iPhone",
                    aspectRatio: 9.0 / 19.5,
                    minSize: nil,
                    image: UIImage(named: "wallpaper-size-selection-iphone"))
            
        case .android:
            return (key:"android",
                    title:"Android",
                    aspectRatio: 10.0 / 16.0,
                    minSize: nil,
                    image: UIImage(named: "wallpaper-size-selection-android"))
            
        case .mac:
            return (key:"mac",
                    title:"Mac",
                    aspectRatio: 16.0 / 9.0,
                    minSize: nil,
                    image: UIImage(named: "wallpaper-size-selection-mac"))
            
        case .resolution4K:
            return (key:"resolution4K",
                    title:"4K",
                    aspectRatio: 10.0 / 16.0,
                    minSize: CGSize(width:3840.0,height:2160.0),
                    image: UIImage(named: "wallpaper-size-selection-4k"))
            
        case .lock:
            return (key:"lock",
                    title:"lock",
                    aspectRatio: 9.0 / 19.5,
                    minSize: nil,
                    image: UIImage(named: "wallpaper-size-selection-lock"))
            
        case .ipad:
            return (key:"ipad",
                    title:"iPad",
                    aspectRatio: 4.0 / 3.0,
                    minSize: nil,
                    image: UIImage(named: "wallpaper-size-selection-ipad"))

        }
    }

    public func adaptWallpaperSize(width:CGFloat, height:CGFloat) -> Bool{
        
        if let aspectRatio = self.rawValue.aspectRatio{
            
            let ratio = Double(width / height)
            if((ratio - 1.0) * (aspectRatio - 1.0) < 0){
                return false
            }
            
            let threshold = 0.50
            if(fabs(ratio - aspectRatio) > threshold){
                return false
            }
        }
        
        if let minSize = self.rawValue.minSize{
            if(width < minSize.width || height < minSize.height){
                return false
            }
        }
        
        return true
    }
}
