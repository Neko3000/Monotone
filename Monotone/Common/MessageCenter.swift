//
//  MessageCenter.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/11.
//

import Foundation

import SwiftMessages

class MessageCenter{
    
    // MARK: - Single Skeleton
    public static let shared = MessageCenter()
    
    init() {

    }
    
    public func showMessage(title: String,
                            body: String,
                            theme: Theme,
                            buttonTapHandler:(() -> Void)? = nil,
                            tapHandler:(() -> Void)? = nil){
        
        SwiftMessages.show {
            let view = MessageView.viewFromNib(layout: .messageView)
            view.configureDropShadow()
            
            
            view.configureContent(title: title, body: body)
                        
            view.button?.isHidden = true
            view.configureTheme(theme)

            if let buttonTapHandler = buttonTapHandler{
                view.buttonTapHandler = { (_) in
                    buttonTapHandler()
                }
                view.button?.isHidden = false
            }
            
            if let tapHandler = tapHandler{
                view.tapHandler = { (_) in
                    tapHandler()
                }
                view.button?.isHidden = false
            }
                        
            return view
        }
    }
    
    
}
