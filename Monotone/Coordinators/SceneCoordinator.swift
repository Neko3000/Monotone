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

// MARK: - Scene
enum Scene {
    case login
    case home
    case photoDetails([String: Any?]?)
    case photoInfo([String: Any?]?)
    case photoShare([String: Any?]?)
    case photoAddToCollection([String: Any?]?)
    case photoCreateCollection([String: Any?]?)
}

// MARK: - SceneContent
enum SceneContent {
    case login
    case home
    case photoDetails([String: Any?]?)
    case photoInfo([String: Any?]?)
    case photoShare([String: Any?]?)
    case photoAddToCollection([String: Any?]?)
    case photoCreateCollection([String: Any?]?)

    case listPhotos([String: Any?]?)
    case searchPhotos([String: Any?]?)
    case empty
}

// MARK: - SceneCoordinator
class SceneCoordinator: BaseCoordinator, CoordinatorTransitionable{
    
    // MARK: - Single Skeleton
    static var shared: SceneCoordinator!
    
    // MARK: - Public
    override var currentViewController: UIViewController? {
        didSet{
            currentViewController?.tabBarController?.delegate = self
            currentViewController?.navigationController?.delegate = self
            
            currentViewController?.presentationController?.delegate = self
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
                    .map({ (_) in return () })
                    .bind(to: subject)
                
                navigationController.pushViewController(SceneCoordinator.actualViewController(for: targetVC), animated: animated)
            }
            else{
                let navigationController = MTNavigationController(rootViewController: targetVC)
                navigationController.modalPresentationStyle = .fullScreen
                
                _ = navigationController.rx.delegate
                    .sentMessage(#selector(navigationController(_:didShow:animated:)))
                    .map({ (_) in return () })
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
        }
    
        
        return subject.asObserver().take(1)
    }
    
    @discardableResult
    func pop(animated: Bool = false) -> Observable<Void>{
        let subject = PublishSubject<Void>()

        if let presentingViewController = self.currentViewController?.presentingViewController{
            
            self.currentViewController?.dismiss(animated: true, completion: {
                self.currentViewController = SceneCoordinator.actualViewController(for: presentingViewController)
                
                if let vc = presentingViewController as? ViewControllerPresentable{
                    vc.didDismissPresentingViewController(presentationController: presentingViewController.presentationController)
                }
            })
            
        }
        else if let navigationController = self.currentViewController?.navigationController{
            
            _ = navigationController.rx.delegate
                .sentMessage(#selector(navigationController(_:didShow:animated:)))
                .map({ (_) in return () })
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

// MARK: FactoryCoordinator
extension SceneCoordinator: FactoryCoordinator{
    typealias sceneType = Scene
    typealias sceneContentType = SceneContent
    
    // MARK: - ViewController Factory
    func viewController(scene: Scene) -> BaseViewController?{
        
        switch scene {
        case .login:
            let vc = LoginViewController()
            let loginVM = self.viewModel(sceneContent:.login)!
            vc.bind(to: [loginVM])
            return vc
            
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
            
        case let .photoInfo(args):
            let vc = PhotoInfoViewController()
            let photoInfoVM = self.viewModel(sceneContent: .photoInfo(args))!
            vc.bind(to: [photoInfoVM])
            
            return vc
            
        case let .photoShare(args):
            let vc = PhotoShareViewController()
            let photoShareVM = self.viewModel(sceneContent: .photoShare(args))!
            vc.bind(to: [photoShareVM])
            
            return vc
            
        case let .photoAddToCollection(args):
            let vc = PhotoAddToCollectionViewController()
            let photoAddToCollectionVM = self.viewModel(sceneContent: .photoAddToCollection(args))!
            vc.bind(to: [photoAddToCollectionVM])
            
            return vc
            
        case let .photoCreateCollection(args):
            let vc = PhotoCreateCollectionViewController()
            let photoCreateCollectionVM = self.viewModel(sceneContent: .photoCreateCollection(args))!
            vc.bind(to: [photoCreateCollectionVM])
            
            return vc

        }
    }
    
    // MARK: - ViewModel Factory
    func viewModel(sceneContent: SceneContent) -> BaseViewModel?{
        
        switch sceneContent {
        case .login:
            let vm: LoginViewModel = LoginViewModel(services: [AuthService()], args: nil)
            return vm
            
        case .home:
            let vm: HomeViewModel = HomeViewModel(services: [PhotoService(),TopicService()], args: nil)
            return vm
            
        case let .photoDetails(args):
            let vm: PhotoDetailsViewModel = PhotoDetailsViewModel(services: [PhotoService()], args: args)
            return vm
            
        case let .photoInfo(args):
            let vm: PhotoInfoViewModel = PhotoInfoViewModel(services: [PhotoService()], args: args)
            return vm
            
        case let .photoShare(args):
            let vm: PhotoShareViewModel = PhotoShareViewModel(services: nil, args: args)
            return vm
            
        case let .photoAddToCollection(args):
            let vm: PhotoAddToCollectionViewModel = PhotoAddToCollectionViewModel(services: [UserService(),CollectionService()], args: args)
            return vm
            
        case let .photoCreateCollection(args):
            let vm: PhotoCreateCollectionViewModel = PhotoCreateCollectionViewModel(services: [CollectionService()], args: args)
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

// MARK: - UITabBarControllerDelegate
extension SceneCoordinator: UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        self.currentViewController = SceneCoordinator.actualViewController(for: viewController)
    }
}

// MARK: - UINavigationControllerDelegate
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

// MARK: - UIAdaptivePresentationControllerDelegate
extension SceneCoordinator: UIAdaptivePresentationControllerDelegate{
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        
        // When the presented ViewController dismissed.
        self.currentViewController = SceneCoordinator.actualViewController(for: presentationController.presentingViewController)
        
    }
}

