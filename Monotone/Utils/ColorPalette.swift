//
//  ColorPalette.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/10/31.
//

import Foundation
import UIKit
import Hue

class ColorPalette{
    
    // MARK: - Static Methods
    public static func colorWithDarkMode(darkColor:UIColor, lightColor:UIColor) -> UIColor{
        var color:UIColor?
        if #available(iOS 13.0, *){
            color = UIColor.init(dynamicProvider: { (traitCollection:UITraitCollection) -> UIColor in
                if(traitCollection.userInterfaceStyle == .dark){
                    return darkColor
                }
                else{
                    return lightColor
                }
            })
        }
        else{
            color = lightColor
        }
        
        return color!
    }
    
    public static func colorWithDarkMode(darkColorHex:String, lightColorHex:String) -> UIColor{
        var color:UIColor?
        if #available(iOS 13.0, *){
            color = UIColor.init(dynamicProvider: { (traitCollection:UITraitCollection) -> UIColor in
                if(traitCollection.userInterfaceStyle == .dark){
                    return UIColor(hex: darkColorHex)
                }
                else{
                    return UIColor(hex: lightColorHex)
                }
            })
        }
        else{
            color = UIColor(hex: lightColorHex)
        }
        
        return color!
    }
    
    public static func colorWithUserInterfaceStyle(color: UIColor, with userInterfaceStyle: UIUserInterfaceStyle) -> UIColor{
        let traitCollection: UITraitCollection = UITraitCollection.init(userInterfaceStyle: userInterfaceStyle)
        return color.resolvedColor(with: traitCollection)
    }
    
    // MARK: - Color Varibles
    public static var colorBlack:UIColor{
        return self.colorWithDarkMode(darkColorHex: "#ffffff", lightColorHex: "#000000")
    }
    
    public static var colorGrayLighter:UIColor{
        // FIXME: waiting dark color
        return self.colorWithDarkMode(darkColorHex: "#000000", lightColorHex: "#ededed")
    }
    
    public static var colorGrayLight:UIColor{
        // FIXME: waiting dark color
        return self.colorWithDarkMode(darkColorHex: "#000000", lightColorHex: "#9b9b9b")
    }
    
    public static var colorGrayNormal:UIColor{
        // FIXME: waiting dark color
        return self.colorWithDarkMode(darkColorHex: "#000000", lightColorHex: "#999999")
    }
    
    public static var colorGrayHeavy:UIColor{
        // FIXME: waiting dark color
        return self.colorWithDarkMode(darkColorHex: "#000000", lightColorHex: "#4a4a4a")
    }
    
    public static var colorWhite:UIColor{
        return self.colorWithDarkMode(darkColorHex: "#000000", lightColorHex: "#ffffff")
    }
    
    public static var colorShadow:UIColor{
        return UIColor.black.alpha(0.09)
    }
    
    // FIXME: To Archive
    public static var colorDenim:UIColor{
        return self.colorWithDarkMode(darkColorHex: "#3c5080", lightColorHex: "#3c5080")
    }
}
