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
        return self.colorWithDarkMode(darkColorHex: "#242424", lightColorHex: "#ededed")
    }
    
    public static var colorGrayLight:UIColor{
        return self.colorWithDarkMode(darkColorHex: "#4a4a4a", lightColorHex: "#9b9b9b")
    }
    
    public static var colorGrayNormal:UIColor{
        return self.colorWithDarkMode(darkColorHex: "#999999", lightColorHex: "#999999")
    }
    
    public static var colorGrayHeavy:UIColor{
        return self.colorWithDarkMode(darkColorHex: "#9b9b9b", lightColorHex: "#4a4a4a")
    }
    
    public static var colorGrayHeavier:UIColor{
        return self.colorWithDarkMode(darkColorHex: "#ededed", lightColorHex: "#242424")
    }
    
    public static var colorWhite:UIColor{
        return self.colorWithDarkMode(darkColorHex: "#000000", lightColorHex: "#ffffff")
    }
    
    public static var colorShadow:UIColor{
        return UIColor.black.alpha(0.09)
    }
    
    public static var colorOverlayer:UIColor{
        return self.colorWithDarkMode(darkColor: UIColor.black.alpha(0.6), lightColor: UIColor.black.alpha(0.4))
    }
    
    public static var colorDenim:UIColor{
        return self.colorWithDarkMode(darkColorHex: "#3c5080", lightColorHex: "#3c5080")
    }
    
    public static var colorGreen:UIColor{
        return self.colorWithDarkMode(darkColorHex: "#2cb191", lightColorHex: "#2cb191")
    }
    
    public static var colorRed:UIColor{
        return self.colorWithDarkMode(darkColorHex: "#bb055a", lightColorHex: "#bb055a")
    }
}
