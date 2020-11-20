//
//  BaseViewController.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/10/30.
//

import UIKit
import RxSwift

protocol ViewControllerBindable{
    
    var viewModels: [BaseViewModel]? { get }
    
    func bind(to viewModels: [BaseViewModel]?)
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

class BaseViewController: UIViewController, ViewControllerBindable {
    
    // MARK: ViewControllerBindable
    var viewModels: [BaseViewModel]?

    // MARK: Life Cycle
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
