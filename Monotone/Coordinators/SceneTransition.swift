//
//  SceneTransition.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/12.
//

import Foundation
import UIKit

enum SceneTransition{
    case root(Scene)
    case push(Scene)
    case present(Scene, UIModalPresentationStyle)
}
