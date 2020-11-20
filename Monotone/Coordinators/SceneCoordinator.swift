//
//  Coordinator.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/12.
//

import Foundation
import UIKit

import RxSwift

class SceneCoordinator: BaseCoordinator, CoordinatorTransitionable{
    
    enum Scene {
        case home
        case photoDetails([String: Any])
    }
    
    enum SceneContent {
        case listPhotos([String: Any]?)
        case searchPhotos([String: Any]?)
        case empty
    }
    
    override var firstViewController: UIViewController {
        get{
            return self.viewController(scene: .home)!
        }
    }
    
    func transition(to scene: Scene?, with args: [String : Any]?, type: SceneTransition?) -> Observable<Void> {
        let subject = PublishSubject<Void>()
        
        
        
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
            let listPhotosVM = self.viewModel(sceneContent:.listPhotos(nil))!
            let searchPhotosVM = self.viewModel(sceneContent:.searchPhotos(nil))!
            vc.bind(to: [listPhotosVM, searchPhotosVM])

            return vc
        default:
            return nil
        }
    }
    
    // MARK: ViewModel Factory
    func viewModel(sceneContent: SceneContent) -> BaseViewModel?{
        
        switch sceneContent {
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
