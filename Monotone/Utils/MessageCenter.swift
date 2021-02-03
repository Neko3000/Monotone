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
                            theme: Theme = .success,
                            buttonText: String? = nil,
                            buttonTapHandler:(() -> Void)? = nil,
                            tapHandler:(() -> Void)? = nil){
        
        SwiftMessages.show {
            let view = MessageView.viewFromNib(layout: .messageView)
            view.configureDropShadow()
            
            view.configureContent(title: title, body: body)
            view.configureTheme(theme)

            if let buttonTapHandler = buttonTapHandler{
                view.buttonTapHandler = { (_) in
                    buttonTapHandler()
                }
                view.button?.setTitle(buttonText, for: .normal)
                view.button?.isHidden = false
            } else{
                view.button?.isHidden = true
            }
            
            if let tapHandler = tapHandler{
                view.tapHandler = { (_) in
                    tapHandler()
                }
            }
                        
            return view
        }
    }
    
    
}
