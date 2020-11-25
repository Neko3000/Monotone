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
    
//    func transition(to scene: sceneType?, with args: [String: Any]?, type: SceneTransition?) -> Observable<Void>
    func transition(type: SceneTransition, with args: [String : Any]?) -> Observable<Void>

}

class BaseCoordinator: NSObject, Coordinator {

    var childCoordinators: [Coordinator] = [Coordinator]()
    var firstViewController: UIViewController{
        get {
           return UIViewController()
        }
    }
    
    var window: UIWindow
    var currentViewController: UIViewController?
    
    init(window: UIWindow){
        self.window = window
        self.currentViewController = window.rootViewController
    }
    
    static func actualViewController(for viewController: UIViewController) -> UIViewController{
        var vc = viewController
        
        if let tabBarController = vc as? UITabBarController{
            guard let selectedViewController = tabBarController.selectedViewController else{
                return tabBarController
            }
            
            vc = selectedViewController
            return actualViewController(for: vc)
        }
        
        if let navigationController = vc as? UINavigationController{
            
            vc = navigationController.viewControllers.first!
            return actualViewController(for: navigationController)
        }
        
        return vc
    }
    
    func start(){
        self.window.rootViewController = self.firstViewController
    }
}
