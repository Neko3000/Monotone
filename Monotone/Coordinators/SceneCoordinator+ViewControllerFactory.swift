//
//  SceneCoordinator+ViewControllerFactory.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/17.
//

import UIKit
import Foundation

// MARK: - ViewControllerFactory
extension SceneCoordinator: ViewControllerFactory{
    
    // MARK: - ViewController Factory
    func viewController(scene: Scene, with args: [String : Any?]?) -> UIViewController?{
        
        switch scene {
        case .login:
            let vc = LoginViewController()
            let loginVM = self.viewModel(sceneContent:.login, with: args)!
            vc.bind(to: [loginVM])
            return vc
            
        case .tabBar:
            let tabBarController = MTTabBarController()
            
            // StoreViewController.
            let storeTabBarItem = UITabBarItem(title: nil,
                                               image: UIImage(named: "tabbar-shop"),
                                               selectedImage: UIImage(named: "tabbar-shop-selected"))
            
            let storeVC = self.viewController(scene: .store, with: args)!
            storeVC.tabBarItem = storeTabBarItem
            
            let storeNavVC = MTNavigationController(rootViewController: storeVC)
            self.configureNavBar(navigationController: storeNavVC)
            
            // WallpapersViewController.
            let wallpapersTabBarItem = UITabBarItem(title: nil,
                                             image: UIImage(named: "tabbar-wallpaper"),
                                             selectedImage: UIImage(named: "tabbar-wallpaper-selected"))
            
            let wallpapersVC = self.viewController(scene: .wallpapers, with: args)!
            wallpapersVC.tabBarItem = wallpapersTabBarItem
            
            let wallpapersNavVC = MTNavigationController(rootViewController: wallpapersVC)
            self.configureNavBar(navigationController: wallpapersNavVC)
            
            // CollectionsViewController.
            let collectionsTabBarItem = UITabBarItem(title: nil,
                                                     image: UIImage(named: "tabbar-collection"),
                                                     selectedImage: UIImage(named: "tabbar-collection-selected"))
            
            let collectionsVC = self.viewController(scene: .collections, with: args)!
            collectionsVC.tabBarItem = collectionsTabBarItem
            
            let collectionsNavVC = MTNavigationController(rootViewController: collectionsVC)
            self.configureNavBar(navigationController: collectionsNavVC)
            
            // ExploreViewController.
            let exploreTabBarItem = UITabBarItem(title: nil,
                                                 image: UIImage(named: "tabbar-explore"),
                                                 selectedImage: UIImage(named: "tabbar-explore-selected"))
            
            let exploreVC = self.viewController(scene: .explore, with: args)!
            exploreVC.tabBarItem = exploreTabBarItem
            
            let exploreNavVC = MTNavigationController(rootViewController: exploreVC)
            self.configureNavBar(navigationController: exploreNavVC)
            
            tabBarController.viewControllers = [
                storeNavVC,
                wallpapersNavVC,
                collectionsNavVC,
                exploreNavVC
            ]
            
            return tabBarController
            
        case .home:
            let vc = HomeViewController()
            let sideMenuVM = self.viewModel(sceneContent:.sideMenu, with: args)!
            let photoListVM = self.viewModel(sceneContent:.photoList, with: args)!
            vc.bind(to: [sideMenuVM, photoListVM])

            return vc
            
        case .sideMenu:
            let vc = SideMenuViewController()
            let sideMenuVM = self.viewModel(sceneContent:.sideMenu,with: args)!
            vc.bind(to: [sideMenuVM])

            return vc
            
        case .photoList:
            let vc = PhotoListViewController()
            let photoListVM = self.viewModel(sceneContent:.photoList, with: args)!
            vc.bind(to: [photoListVM])

            return vc
            
        case .photoDetails:
            let vc = PhotoDetailsViewController()
            let photoDetailsVM = self.viewModel(sceneContent: .photoDetails, with: args)!
            vc.bind(to: [photoDetailsVM])
            
            return vc
            
        case .photoInfo:
            let vc = PhotoInfoViewController()
            let photoInfoVM = self.viewModel(sceneContent: .photoInfo, with: args)!
            vc.bind(to: [photoInfoVM])
            
            return vc
            
        case .photoShare:
            let vc = PhotoShareViewController()
            let photoShareVM = self.viewModel(sceneContent: .photoShare, with: args)!
            vc.bind(to: [photoShareVM])
            
            return vc
            
        case .photoAddToCollection:
            let vc = PhotoAddToCollectionViewController()
            let photoAddToCollectionVM = self.viewModel(sceneContent: .photoAddToCollection, with: args)!
            vc.bind(to: [photoAddToCollectionVM])
            
            return vc
            
        case .photoCreateCollection:
            let vc = PhotoCreateCollectionViewController()
            let photoCreateCollectionVM = self.viewModel(sceneContent: .photoCreateCollection, with: args)!
            vc.bind(to: [photoCreateCollectionVM])
            
            return vc
            
        case .myPhotos:
            let vc = MyPhotosViewController()
            let myPhotosVM = self.viewModel(sceneContent: .myPhotos, with: args)!
            vc.bind(to: [myPhotosVM])
            
            return vc
            
        case .hiring:
            let vc = HiringViewController()
            // let hiringVM = self.viewModel(sceneContent: .hiring, with: args)!
            // vc.bind(to: [hiringVM])
            
            return vc
            
        case .licenses:
            let vc = LicensesViewController()
            let licensesVM = self.viewModel(sceneContent: .licenses, with: args)!
            vc.bind(to: [licensesVM])
            
            return vc
            
        case .help:
            let vc = HelpViewController()
            let helpVM = self.viewModel(sceneContent: .help, with: args)!
            vc.bind(to: [helpVM])
            
            return vc
            
        case .madeWithUnsplash:
            let vc = MadeWithUnsplashViewController()
            let madeWithUnsplashVM = self.viewModel(sceneContent: .madeWithUnsplash, with: args)!
            vc.bind(to: [madeWithUnsplashVM])
            
            return vc
            
        case .store:
            let vc = StoreViewController()
            let storeVM = self.viewModel(sceneContent: .store, with: args)!
            vc.bind(to: [storeVM])
            
            return vc
            
        case .storeDetails:
            let vc = StoreDetailsViewController()
            let storeDetailsVM = self.viewModel(sceneContent: .storeDetails, with: args)!
            vc.bind(to: [storeDetailsVM])
            
            return vc
            
        case .wallpapers:
            let vc = WallpapersViewController()
            let wallpapersVM = self.viewModel(sceneContent: .wallpapers, with: args)!
            vc.bind(to: [wallpapersVM])
            
            return vc
            
        case .collections:
            let vc = CollectionsViewController()
            let collectionsVM = self.viewModel(sceneContent: .collections, with: args)!
            vc.bind(to: [collectionsVM])
            
            return vc
            
        case .collectionDetails:
            let vc = CollectionDetailsViewController()
            let collectionDetailsVM = self.viewModel(sceneContent: .collectionDetails, with: args)!
            vc.bind(to: [collectionDetailsVM])
            
            return vc
            
        case .explore:
            let vc = ExploreViewController()
            let exploreVM = self.viewModel(sceneContent: .explore, with: args)!
            vc.bind(to: [exploreVM])
            
            return vc
        }
    }
}
