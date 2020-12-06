//
//  BaseViewController.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/10/30.
//

import UIKit
import RxSwift

// MARK: - ViewControllerBindable
protocol ViewControllerBindable{
    
    // Stored ViewModels.
    var viewModels: [BaseViewModel]? { get }
    
    // Bind to ViewControler.
    func bind(to viewModels: [BaseViewModel]?)
    // Retrieve ViewModels.
    func viewModel<T: BaseViewModel>(type: T.Type) -> T?
}

extension ViewControllerBindable where Self: BaseViewController{
    
    func bind(to viewModels: [BaseViewModel]?) {
        self.viewModels = viewModels
    }
    
    func viewModel<T>(type: T.Type) -> T? where T : BaseViewModel {
        self.viewModels?.find(by: type)
    }
}

// MARK: - ViewControllerTransitionable
protocol ViewControllerTransitionable {
    // Transition.
    @discardableResult func transition(type: SceneTransition, with args: [String : Any]?, animated: Bool) -> Observable<Void>
    // Pop.
    @discardableResult func pop() -> Observable<Void>
}

extension ViewControllerTransitionable where Self: BaseViewController{
    @discardableResult
    func transition(type: SceneTransition, with args: [String : Any]?, animated: Bool = false) -> Observable<Void>{
        return SceneCoordinator.shared.transition(type: type, with: args, animated: animated)
    }
    
    @discardableResult
    func pop() ->  Observable<Void>{
        return SceneCoordinator.shared.pop()
    }
}

// MARK: - ViewControllerAnimatable
protocol ViewControllerAnimatable {
    associatedtype AnimationStateType
    
    func animation(animationState: AnimationStateType)
}

// MARK: - BaseViewController
class BaseViewController: UIViewController, ViewControllerBindable, ViewControllerTransitionable {
    
    // MARK: - Public
    var navBarTransparent: Bool = false
    var navBarHidden: Bool = false
    
    var viewModels: [BaseViewModel]?
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.buildSubviews()
        self.buildLogic()
        // Do any additional setup after loading the view.
    }
    
    func buildSubviews() {
        
    }
    
    func buildLogic() {
        
    }

}
