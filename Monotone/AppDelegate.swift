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
    var sceneCoordinator: SceneCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.sceneCoordinator = SceneCoordinator(window: self.window!)
        
        self.sceneCoordinator!.start()
        
        return true
    }


}

