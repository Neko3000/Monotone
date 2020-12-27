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
    func viewController(scene: Scene) -> UIViewController?{
        
        switch scene {
        case .login:
            let vc = LoginViewController()
            let loginVM = self.viewModel(sceneContent:.login)!
            vc.bind(to: [loginVM])
            return vc
            
        case .home:
            let vc = PhotoListViewController()
            let homeVM = self.viewModel(sceneContent:.home)!
            vc.bind(to: [homeVM])

            return vc
            
        case .sideMenu:
            let vc = SideMenuViewController()
            let sideMenuVM = self.viewModel(sceneContent:.sideMenu)!
            vc.bind(to: [sideMenuVM])

            return vc
            
        case .tabBar:
            let tabBarController = UITabBarController()
            
            let vc1TabbarItem = UITabBarItem(title: "i am vc1",
                                             image: UIImage(named: "profile-collection"),
                                             selectedImage: UIImage(named: "profile-view-selected"))
            
            let vc1 = UIViewController()
            vc1.tabBarItem = vc1TabbarItem
            vc1.view.backgroundColor = UIColor.purple
            
            let vc2TabbarItem = UITabBarItem(title: "i am vc2",
                                             image: UIImage(named: "profile-like"),
                                             selectedImage: UIImage(named: "profile-like-selected"))
            
            let vc2 = UIViewController()
            vc2.tabBarItem = vc2TabbarItem
            vc2.view.backgroundColor = UIColor.yellow
            
            tabBarController.viewControllers = [
                vc1,
                vc2
            ]
            
            return tabBarController
            
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
            let vm: PhotoListViewModel = PhotoListViewModel(services: [PhotoService(),TopicService()], args: nil)
            return vm
            
        case .sideMenu:
            let vm: SideMenuViewModel = SideMenuViewModel(services: [UserService()], args: nil)
            return vm
            
        case .tabBar:
            return nil
            
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
            
        case let .searchPhotos(args):
            let vm: SearchPhotosViewModel = SearchPhotosViewModel(services: [PhotoService()], args: args)
            return vm
            
        default:
            return nil
        }
    }
}
