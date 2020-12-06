//
//  BaseCoordinator.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/13.
//

import Foundation
import UIKit

import RxSwift

// MARK: Coordinator
protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    
    var firstViewController: UIViewController { get }
    var currentViewController: UIViewController? { get }
}

// MARK: FactoryCoordinator
protocol FactoryCoordinator {
    associatedtype sceneType
    associatedtype sceneContentType
    
    func viewController(scene: sceneType) -> BaseViewController?
    func viewModel(sceneContent: sceneContentType) -> BaseViewModel?
}

// MARK: CoordinatorTransitionable
protocol CoordinatorTransitionable {
    @discardableResult func transition(type: SceneTransition, with args: [String : Any]?, animated: Bool) -> Observable<Void>
    @discardableResult func pop(animated: Bool) -> Observable<Void>
}

// MARK: BaseCoordinator
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
            return actualViewController(for: vc)
        }
        
        return vc
    }
}
