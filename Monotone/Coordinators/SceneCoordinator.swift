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
    case sideMenu
    case photoList
    case tabBar
    case photoDetails([String: Any?]?)
    case photoInfo([String: Any?]?)
    case photoShare([String: Any?]?)
    case photoAddToCollection([String: Any?]?)
    case photoCreateCollection([String: Any?]?)
    
    case myPhotos
}

// MARK: - SceneContent
enum SceneContent {
    case login
    case home
    case sideMenu
    case photoList
    case tabBar
    case photoDetails([String: Any?]?)
    case photoInfo([String: Any?]?)
    case photoShare([String: Any?]?)
    case photoAddToCollection([String: Any?]?)
    case photoCreateCollection([String: Any?]?)
    
    case myPhotos

    case searchPhotos([String: Any?]?)
    case empty
}

// MARK: - SceneCoordinator
class SceneCoordinator: BaseCoordinator, CoordinatorTransitionable{
    
    // MARK: - Single Skeleton
    static var shared: SceneCoordinator!
    
    // MARK: - Public
    override weak var currentViewController: UIViewController? {
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
    
    // MARK: - Private
    private let disposeBag: DisposeBag = DisposeBag()
    
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
                
                self.configureNavBar(navigationController: navigationController)
                
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
        
        case let .root(scene,wrapped):
            
            var targetVC = self.viewController(scene: scene)!
            
            if(wrapped){
                let navigationController = MTNavigationController(rootViewController: targetVC)
                
                self.configureNavBar(navigationController: navigationController)
                
                targetVC = navigationController
            }
            
            self.currentViewController = SceneCoordinator.actualViewController(for: targetVC)
            self.window.rootViewController = targetVC
            
            subject.onCompleted()
            
            break
            
        case let .present(scene,presetationStyle,wrapped):
            
            var targetVC = self.viewController(scene: scene)!
            
            if(wrapped){
                let navigationController = MTNavigationController(rootViewController: targetVC)
                navigationController.modalPresentationStyle = presetationStyle
                
                self.configureNavBar(navigationController: navigationController)
                
                targetVC = navigationController
            }
        
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

        if let navigationController = self.currentViewController?.navigationController,
           navigationController.viewControllers.count > 1{
            
            _ = navigationController.rx.delegate
                .sentMessage(#selector(navigationController(_:didShow:animated:)))
                .map({ (_) in return () })
                .bind(to: subject)
            
            guard navigationController.popViewController(animated: animated) != nil else{
                fatalError("Could not navigate back from current view controller.")
            }
        }
        else if let presentingViewController = self.currentViewController?.presentingViewController{
            
            self.currentViewController?.dismiss(animated: true, completion: {
                self.currentViewController = SceneCoordinator.actualViewController(for: presentingViewController)
                
                if let vc = presentingViewController as? ViewControllerPresentable{
                    vc.didDismissPresentingViewController(presentationController: presentingViewController.presentationController)
                }
            })
            
        }
        else{
            fatalError("Could not pop back from current view controller.")
        }
        
        return subject.asObserver().take(1)
    }
    
    // MARK: - ConfigureNavBar
    private func configureNavBar(navigationController: MTNavigationController){
        
        Observable.of(navigationController.closeBtnDidTap,navigationController.backBtnDidTap)
            .merge()
            .subscribe(onNext:{ [weak self] _ in
                guard let self = self else { return }

                self.pop(animated: true)
            })
            .disposed(by: self.disposeBag)
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
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let topVC = viewController as? BaseViewController,
           let navVC = navigationController as? BaseNavigationController{
            navVC.updateNavBarTransparent(transparent:topVC.navBarTransparent)
            navVC.updateNavBarHidden(hidden:topVC.navBarHidden)
            navVC.updateNavItems(color:topVC.navBarItemsColor)
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        self.currentViewController = SceneCoordinator.actualViewController(for: viewController)
    }
}

// MARK: - UIAdaptivePresentationControllerDelegate
extension SceneCoordinator: UIAdaptivePresentationControllerDelegate{
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        
        // When the presented ViewController dismissed.
        self.currentViewController = SceneCoordinator.actualViewController(for: presentationController.presentingViewController)
        
    }
}

