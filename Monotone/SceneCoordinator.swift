//
//  Coordinator.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/12.
//

import Foundation
import UIKit

import RxSwift

protocol CoordinatorProtocol {
    var childCoordinators : [Coordinator] { get set }
    func start()
    func transite(to: SceneProtocol)
}

protocol FactoryCoordinatorProtocol {
    associatedtype sceneType
    
    func viewController(scene: sceneType) -> BaseViewController
    func viewModel(viewModelType: AnyClass, userInfo: [String: Any]) -> BaseViewModel
}

class BaseCoordinator: CoordinatorProtocol {

    var childCoordinators: [Coordinator] = [Coordinator]()
    
    private var navigationViewController: UINavigationController?
    
    init(navigationViewController: UINavigationController) {
        self.navigationViewController = navigationViewController
    }
    
    init() {
        self.navigationViewController = UINavigationController()
    }
    
    func start() {
        
    }
    
    func transite(to: SceneProtocol) {
        
    }
    
}

class SceneCoordinator: BaseCoordinator{
    enum Scene: SceneProtocol {
        case Home([String: Any])
        case PhotoDetails([String: Any])
    }
    
    enum ViewModel {
        case ListPhotosViewModel()
    }
    
    public func transition(to: Scene, userInfo: [String: Any], type: SceneTransition) -> Observable<Void>{
        let subject = PublishSubject<Void>()
        
        return subject.take(1)
    }
    

    
}

extension SceneCoordinator: FactoryCoordinator{
    typealias sceneType = Scene
    
    // MARK: ViewController Factory
    internal func viewController(scene: Scene) -> BaseViewController{
        
        
        switch scene {
        case let .Home(userInfo):
            let vc = HomeViewController()
            let vm = self.viewModel(viewModelType: ListPhotosViewModel.self, userInfo: userInfo) as! ListPhotosViewModel
            vc.bind(to: vm)

            return vc
        default:
            return BaseViewController()
            break
        }
    }
    
    // MARK: ViewModel Factory
    internal func viewModel(viewModelType: AnyClass, userInfo: [String: Any]) -> BaseViewModel{
        return ListPhotosViewModel(service: PhotoService())
    }
}

protocol SceneProtocol {
    
}


class PhotoCoordinator: BaseCoordinator {
    enum Scene: SceneProtocol {
        case Home(ListPhotosViewModel)
        case PhotoDetails
    }
    
    override func start() {
        
    }
    
    override func transite(to targetScene: SceneProtocol) {
        let scene = targetScene as! Scene
        
        switch scene {
        case let .Home(viewModel):
            var vc = HomeViewController()
            vc.bind(to: viewModel)
            
            break
        case let .PhotoDetails:
            var vc = PhotoDetailsViewController()
            
            
        default:
            break
        }
    }
    
}
