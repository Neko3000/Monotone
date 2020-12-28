//
//  AppDelegate.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/10/29.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window!.makeKeyAndVisible()
        
        SceneCoordinator.shared = SceneCoordinator(window: self.window!)
        SceneCoordinator.shared.transition(type: .root(.home), with: nil)
        
        return true
    }


}

