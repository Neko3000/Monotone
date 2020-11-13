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
        case home([String: Any])
        case photoDetails([String: Any])
    }
    
    enum SceneContent {
        case listPhotos([String: Any])
        case searchPhotos([String: Any])
        case empty
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
    internal func viewController(scene: Scene) -> BaseViewController?{
        
        switch scene {
        case let .home(args):
            let vc = HomeViewController()
            let vm = self.viewModel(sceneContent:.searchPhotos(args))
            vc.bind(to: vm as? ListPhotosViewModel)

            return vc
        default:
            return nil
        }
    }
    
    // MARK: ViewModel Factory
    internal func viewModel(sceneContent: SceneContent) -> BaseViewModel?{
        
        switch sceneContent {
        case let .listPhotos(args):
            let vm: ListPhotosViewModel = ListPhotosViewModel(service: PhotoService(), args: args)
            return vm
            
        default:
            return nil
        }        
    }
}
