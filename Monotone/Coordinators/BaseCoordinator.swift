//
//  BaseCoordinator.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/13.
//

import Foundation
import UIKit

import RxSwift

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var firstViewController: UIViewController { get }
    
    func start()
}

protocol FactoryCoordinator {
    associatedtype sceneType
    associatedtype sceneContentType
    
    func viewController(scene: sceneType) -> BaseViewController?
    func viewModel(sceneContent: sceneContentType) -> BaseViewModel?
}

protocol CoordinatorTransitionable {
    associatedtype sceneType
    
    func transition(to scene: sceneType?, with args: [String: Any]?, type: SceneTransition?) -> Observable<Void>
}

class BaseCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = [Coordinator]()
    var firstViewController: UIViewController{
        get {
           return UIViewController()
        }
    }
    
    var window: UIWindow?
    
    init(window: UIWindow){
        self.window = window
    }
    
    func start(){
        self.window!.rootViewController = self.firstViewController
        self.window!.makeKeyAndVisible()
    }
}
