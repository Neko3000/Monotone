//
//  Coordinator.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/12.
//

import Foundation
import UIKit

import RxSwift

protocol Coordinator {
    var childCoordinators : [CoordinatorProtocol] { get set }
    func transition()
}

protocol FactoryCoordinator {
    associatedtype sceneType
    associatedtype sceneContentType
    
    func viewController(scene: sceneType) -> BaseViewController?
    func viewModel(sceneContent: sceneContentType) -> BaseViewModel?
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
    
    func transition() {
        // Implemented by subclass.
    }
}

class SceneCoordinator: BaseCoordinator{
    enum Scene {
        case home([String: Any])
        case photoDetails([String: Any])
    }
    
    enum SceneContent {
        case listPhotos([String: Any])
        case searchPhotos([String: Any])
        case empty
    }
    
    public func transition(to: Scene, userInfo: [String: Any], type: SceneTransition) -> Observable<Void>{
        let subject = PublishSubject<Void>()
        
        
        
        return subject.asObserver().take(1)
    }
    

    
}

extension SceneCoordinator: FactoryCoordinator{
    typealias sceneType = Scene
    typealias sceneContentType = SceneContent
    
    // MARK: ViewController Factory
    internal func viewController(scene: Scene) -> BaseViewController?{
        
        switch scene {
        case let .home(userInfo):
            let vc = HomeViewController()
            let vm = self.viewModel(sceneContent:.searchPhotos(userInfo))
            vc.bind(to: vm as! ListPhotosViewModel)

            return vc
        default:
            return nil
        }
    }
    
    // MARK: ViewModel Factory
    internal func viewModel(sceneContent: SceneContent) -> BaseViewModel?{
        
        switch sceneContent {
        case let .listPhotos(userInfo):
            var vm: 
            
            
        default:
            <#code#>
        }
        
        return ListPhotosViewModel(service: PhotoService())
    }
}
