//
//  Coordinator.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/12.
//

import Foundation
import UIKit

import RxSwift
import RxCocoa

enum Scene {
    case home
    case photoDetails([String: Any]?)
}

enum SceneContent {
    case home
    case photoDetails([String: Any]?)
    case listPhotos([String: Any]?)
    case searchPhotos([String: Any]?)
    case empty
}

class SceneCoordinator: BaseCoordinator, CoordinatorTransitionable{
    
    static var shared: SceneCoordinator!
    
    override var currentViewController: UIViewController? {
        didSet{
            currentViewController?.tabBarController?.delegate = self
            currentViewController?.navigationController?.delegate = self
        }
    }

    override var firstViewController: UIViewController {
        get{
            return self.viewController(scene: .home)!
        }
    }
    
    // FIXME: To finish.
    @discardableResult
    func transitionToTabBar() -> Observable<Void>{
        let subject = PublishSubject<Void>()

        return subject.asObserver().take(1)
    }
    
    @discardableResult
    func transition(type: SceneTransition, with args: [String : Any]?, animated: Bool = false) -> Observable<Void> {
        let subject = PublishSubject<Void>()
        
        switch type {
        case let .push(scene):
            
            let targetVC = self.viewController(scene: scene)!
            
            if(self.currentViewController!.navigationController != nil){
                let navigationController = self.currentViewController!.navigationController!
                
                _ = navigationController.rx.delegate
                    .sentMessage(#selector(navigationController(_:didShow:animated:)))
                    .map({ _ in return () })
                    .bind(to: subject)
                
                navigationController.pushViewController(SceneCoordinator.actualViewController(for: targetVC), animated: animated)
            }
            else{
                let navigationController = MTNavigationController(rootViewController: targetVC)
                navigationController.modalPresentationStyle = .fullScreen
                
                _ = navigationController.rx.delegate
                    .sentMessage(#selector(navigationController(_:didShow:animated:)))
                    .map({ _ in return () })
                    .bind(to: subject)
                
                currentViewController!.present(navigationController, animated: animated, completion: {
                    subject.onCompleted()
                })
                
                self.currentViewController = SceneCoordinator.actualViewController(for: targetVC)
            }
            break
        
        case let .root(scene):
            
            let targetVC = self.viewController(scene: scene)!
            
            self.currentViewController = SceneCoordinator.actualViewController(for: targetVC)
            self.window.rootViewController = targetVC
            
            subject.onCompleted()
            
            break
            
        case let .present(scene,presetationStyle):
            
            let targetVC = self.viewController(scene: scene)!
            targetVC.modalPresentationStyle = presetationStyle
        
            currentViewController?.present(targetVC, animated: animated, completion: {
                subject.onCompleted()
            })
            
            self.currentViewController = SceneCoordinator.actualViewController(for: targetVC)
            
            break

        default:
            break
        }
    
        
        return subject.asObserver().take(1)
    }
    
    @discardableResult
    func pop(animated: Bool = false) -> Observable<Void>{
        let subject = PublishSubject<Void>()

        if let presentingViewController = self.currentViewController?.presentingViewController{
            
            self.currentViewController?.dismiss(animated: true, completion: {
                self.currentViewController = SceneCoordinator.actualViewController(for: presentingViewController)
            })
            
        }
        else if let navigationController = self.currentViewController?.navigationController{
            
            _ = navigationController.rx.delegate
                .sentMessage(#selector(navigationController(_:didShow:animated:)))
                .map({ _ in return () })
                .bind(to: subject)
            
            guard navigationController.popViewController(animated: animated) != nil else{
                fatalError("Could not navigate back from current view controller.")
            }
        }
        else{
            fatalError("Could not pop back from current view controller.")
        }
        
        return subject.asObserver().take(1)
    }
}

extension SceneCoordinator: FactoryCoordinator{
    typealias sceneType = Scene
    typealias sceneContentType = SceneContent
    
    // MARK: ViewController Factory
    func viewController(scene: Scene) -> BaseViewController?{
        
        switch scene {
        case .home:
            let vc = HomeViewController()
            let homeVM = self.viewModel(sceneContent:.home)!
            vc.bind(to: [homeVM])

            return vc
            
        case let .photoDetails(args):
            let vc = PhotoDetailsViewController()
            let photoDetailsVM = self.viewModel(sceneContent: .photoDetails(args))!
            vc.bind(to: [photoDetailsVM])
            
            return vc
            
        default:
            return nil
        }
    }
    
    // MARK: ViewModel Factory
    func viewModel(sceneContent: SceneContent) -> BaseViewModel?{
        
        switch sceneContent {
        case .home:
            let vm: HomeViewModel = HomeViewModel(services: [PhotoService(),TopicService()], args: nil)
            return vm
            
        case let .photoDetails(args):
            let vm: PhotoDetailsViewModel = PhotoDetailsViewModel(services: nil, args: args)
            return vm
            
        case let .listPhotos(args):
            let vm: ListPhotosViewModel = ListPhotosViewModel(services: [PhotoService()], args: args)
            return vm
            
        case let .searchPhotos(args):
            let vm: SearchPhotosViewModel = SearchPhotosViewModel(services: [PhotoService()], args: args)
            return vm
            
        default:
            return nil
        }        
    }
}

extension SceneCoordinator: UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        self.currentViewController = SceneCoordinator.actualViewController(for: viewController)
    }
}

extension SceneCoordinator: UINavigationControllerDelegate{
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        self.currentViewController = SceneCoordinator.actualViewController(for: viewController)
        
        if let topVC = viewController as? BaseViewController,
           let navVC = navigationController as? BaseNavigationController{
            navVC.updateNavBarTransparent(transparent:topVC.navBarTransparent)
            navVC.updateNavBarHidden(hidden:topVC.navBarHidden)
        }
    }
}

