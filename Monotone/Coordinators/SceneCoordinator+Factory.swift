//
//  SceneCoordinator+Factory.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/17.
//

import Foundation

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
