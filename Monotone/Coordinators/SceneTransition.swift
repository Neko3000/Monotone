//
//  SceneTransition.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/12.
//

import Foundation
import UIKit

enum SceneTransition{
    case root(scene: Scene, wrapped: Bool = false)
    case push(scene: Scene)
    case present(scene: Scene, presentationStyle: UIModalPresentationStyle = .fullScreen, warpped: Bool = false)
}
