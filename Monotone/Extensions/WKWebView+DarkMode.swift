//
//  WKWebView+DarkMode.swift
//  Monotone
//
//  Created by Xueliang Chen on 2021/2/3.
//

import Foundation
import UIKit
import WebKit

extension WKWebView{
    
    // https://stackoverflow.com/questions/57203909/how-to-use-ios-13-darkmode-for-wkwebview
    // by Dhaval Bhimani, answered Apr 16 '20 at 11:03.
    public func toDark(){
        let cssString = "@media (prefers-color-scheme: dark) {body { background-color: black; color: white;} a:link {color: #0096e2;} a:visited {color: #9d57df;}}"
        let jsString = "var style = document.createElement('style'); style.innerHTML = '\(cssString)'; document.head.appendChild(style);"
        self.evaluateJavaScript(jsString, completionHandler: nil)
     }
}
