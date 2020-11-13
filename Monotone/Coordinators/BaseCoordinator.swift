//
//  BaseCoordinator.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/13.
//

import Foundation

import RxSwift

protocol Coordinator {
    var childCoordinators : [Coordinator] { get set }
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
    
    private var navigationViewController: UINavigationController?
    
    init(navigationViewController: UINavigationController) {
        self.navigationViewController = navigationViewController
    }
    
    init() {
        self.navigationViewController = UINavigationController()
    }
}
