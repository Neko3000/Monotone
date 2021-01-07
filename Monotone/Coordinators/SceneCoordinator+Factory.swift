//
//  SceneCoordinator+Factory.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/17.
//

import UIKit
import Foundation

// MARK: - FactoryCoordinator
extension SceneCoordinator: FactoryCoordinator{
    typealias sceneType = Scene
    typealias sceneContentType = SceneContent
    
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
            
            // vc1
            let vc1TabbarItem = UITabBarItem(title: nil,
                                             image: UIImage(named: "tabbar-shop"),
                                             selectedImage: UIImage(named: "tabbar-shop-selected"))
            
            let vc1 = UIViewController()
            vc1.tabBarItem = vc1TabbarItem
            vc1.view.backgroundColor = UIColor.purple
            let nav1 = UINavigationController(rootViewController: vc1)
            
            
            // vc2
            let vc2TabbarItem = UITabBarItem(title: nil,
                                             image: UIImage(named: "tabbar-wallpaper"),
                                             selectedImage: UIImage(named: "tabbar-wallpaper-selected"))
            
            let vc2 = UIViewController()
            vc2.tabBarItem = vc2TabbarItem
            vc2.view.backgroundColor = UIColor.yellow
            let nav2 = UINavigationController(rootViewController: vc2)

            
            // vc3
            let vc3TabbarItem = UITabBarItem(title: nil,
                                             image: UIImage(named: "tabbar-collection"),
                                             selectedImage: UIImage(named: "tabbar-collection-selected"))
            
            let vc3 = UIViewController()
            vc3.tabBarItem = vc3TabbarItem
            vc3.view.backgroundColor = UIColor.magenta
            let nav3 = UINavigationController(rootViewController: vc3)
            
            
            // vc4
            let vc4TabbarItem = UITabBarItem(title: nil,
                                             image: UIImage(named: "tabbar-explore"),
                                             selectedImage: UIImage(named: "tabbar-explore-selected"))
            
            let vc4 = UIViewController()
            vc4.tabBarItem = vc4TabbarItem
            vc4.view.backgroundColor = UIColor.orange
            let nav4 = UINavigationController(rootViewController: vc4)
            
            tabBarController.viewControllers = [
                nav1,
                nav2,
                nav3,
                nav4
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

        }
    }
    
    // MARK: - ViewModel Factory
    func viewModel(sceneContent: SceneContent, with args: [String : Any?]?) -> BaseViewModel?{
        
        switch sceneContent {
        case .login:
            let vm: LoginViewModel = LoginViewModel(services: [AuthService(),UserService()], args: nil)
            return vm
            
        case .tabBar:
            return nil
            
        case .home:
            return nil
            
        case .sideMenu:
            let vm: SideMenuViewModel = SideMenuViewModel(services: [UserService()], args: nil)
            return vm
            
        case .photoList:
            let vm: PhotoListViewModel = PhotoListViewModel(services: [PhotoService(),TopicService()], args: nil)
            return vm
            
        case .photoDetails:
            let vm: PhotoDetailsViewModel = PhotoDetailsViewModel(services: [PhotoService()], args: args)
            return vm
            
        case .photoInfo:
            let vm: PhotoInfoViewModel = PhotoInfoViewModel(services: [PhotoService()], args: args)
            return vm
            
        case .photoShare:
            let vm: PhotoShareViewModel = PhotoShareViewModel(services: nil, args: args)
            return vm
            
        case .photoAddToCollection:
            let vm: PhotoAddToCollectionViewModel = PhotoAddToCollectionViewModel(services: [UserService(),CollectionService()], args: args)
            return vm
            
        case .photoCreateCollection:
            let vm: PhotoCreateCollectionViewModel = PhotoCreateCollectionViewModel(services: [CollectionService()], args: args)
            return vm
            
        case .myPhotos:
            let vm: MyPhotosViewModel = MyPhotosViewModel(services: [UserService()], args: args)
            return vm
            
        case .hiring:
            return nil
            
        case .licenses:
            let vm: LicensesViewModel = LicensesViewModel(services: nil, args: args)
            return vm
            
        case .help:
            let vm: HelpViewModel = HelpViewModel(services: nil, args: args)
            return vm
            
        case .searchPhotos:
            let vm: SearchPhotosViewModel = SearchPhotosViewModel(services: [PhotoService()], args: args)
            return vm
            
        default:
            return nil
        }
    }
}
