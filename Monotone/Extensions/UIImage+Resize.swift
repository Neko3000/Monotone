//
//  UIImage+Resize.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/17.
//

import Foundation
import UIKit

extension UIImage{
    
    // https://stackoverflow.com/questions/2658738/the-simplest-way-to-resize-an-uiimage
    // by Rogerio Chaves at Jun/30.
    public func resize(to size: CGSize, retina: Bool = true) -> UIImage? {
         // In next line, pass 0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
         // Pass 1 to force exact pixel size.
         UIGraphicsBeginImageContextWithOptions(
             /* size: */ size,
             /* opaque: */ false,
             /* scale: */ retina ? 0 : 1
         )
         defer { UIGraphicsEndImageContext() }

         self.draw(in: CGRect(origin: .zero, size: size))
         return UIGraphicsGetImageFromCurrentImageContext()
     }
}
