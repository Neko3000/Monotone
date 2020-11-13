//
//  SceneTransition.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/12.
//

import Foundation
import UIKit

enum SceneTransition{
    case root(UIViewController)
    case push(UIViewController)
    case present(UIViewController)
    case alert(UIViewController)
    case tabbar(UITabBarController)
}
