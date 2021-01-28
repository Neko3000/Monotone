//
//  UIImageView+Set.swift
//  Monotone
//
//  Created by Xueliang Chen on 2021/1/29.
//

import Foundation
import UIKit

import Kingfisher

enum PhotoSize {
    case raw
    case full
    case regular
    case small
    case thumb
}

enum UserAvatarSize {
    case large
    case medium
    case small
}

extension UIImageView{
    
    func setPhoto(photo: Photo?, size: PhotoSize = .full){
        guard let photo = photo else { return }
        
        var location:String? = nil
        
        switch size {
        case .raw:
            location = photo.urls?.raw
        case .full:
            location = photo.urls?.full
        case .regular:
            location = photo.urls?.regular
        case .small:
            location = photo.urls?.small
        case .thumb:
            location = photo.urls?.thumb
        }
        
        guard let url = location else { return }
        self.kf.setImage(with: URL(string: url),
                         placeholder: UIImage(blurHash: photo.blurHash ?? "", size: CGSize(width: 10, height: 10)),
                         options: [.transition(.fade(0.7)),
                                   .cacheOriginalImage,
                                   .originalCache(.default)])
    }
    
    func setUserAvatar(user: User?, size: UserAvatarSize = .large){
        guard let user = user else { return }
        
        var location:String? = nil
        
        switch size {
        case .large:
            location = user.profileImage?.large
        case .medium:
            location = user.profileImage?.medium
        case .small:
            location = user.profileImage?.small
        }
        
        guard let url = location else { return }
        self.kf.setImage(with: URL(string: url),
                         options: [.transition(.fade(0.7)),
                                   .cacheOriginalImage,
                                   .originalCache(.default)])
    }
}
