//
//  SceneCoordinator+ViewModelFactory.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/17.
//

import UIKit
import Foundation

// MARK: - ViewModelFactory
extension SceneCoordinator: ViewModelFactory{
    
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
            
        case .madeWithUnsplash:
            let vm: MadeWithUnsplashViewModel = MadeWithUnsplashViewModel(services: nil, args: args)
            return vm
            
        case .store:
            let vm: StoreViewModel = StoreViewModel(services: nil, args: args)
            return vm
            
        case .storeDetails:
            let vm: StoreDetailsViewModel = StoreDetailsViewModel(services: nil, args: args)
            return vm
            
        case .wallpapers:
            let vm: WallpapersViewModel = WallpapersViewModel(services: [TopicService()], args: args)
            return vm
            
        case .collections:
            let vm: CollectionsViewModel = CollectionsViewModel(services: [CollectionService()], args: args)
            return vm
            
        default:
            return nil
        }
    }
}
