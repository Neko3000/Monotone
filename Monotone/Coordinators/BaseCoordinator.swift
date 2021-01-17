//
//  BaseCoordinator.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/13.
//

import Foundation
import UIKit

import RxSwift

// MARK: - Coordinator
protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var currentViewController: UIViewController? { get }
}

// MARK: - ViewControllerFactory
protocol ViewControllerFactory {
    associatedtype sceneType
    associatedtype sceneContentType
    
    func viewController(scene: sceneType, with args: [String : Any?]?) -> UIViewController?
}

// MARK: - ViewModelFactory
protocol ViewModelFactory {
    associatedtype sceneType
    associatedtype sceneContentType
    
    func viewModel(sceneContent: sceneContentType, with args: [String : Any?]?) -> BaseViewModel?
}

// MARK: - CoordinatorTransitionable
protocol CoordinatorTransitionable {
    @discardableResult func transition(type: SceneTransition, with args: [String : Any?]?, animated: Bool) -> Observable<Void>
    @discardableResult func pop(animated: Bool) -> Observable<Void>
}

// MARK: - BaseCoordinator
class BaseCoordinator: NSObject, Coordinator {

    // MARK: - Public
    var childCoordinators: [Coordinator] = [Coordinator]()
    
    var window: UIWindow
    weak var currentViewController: UIViewController?
    
    // MARK: - Life Cycle
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
