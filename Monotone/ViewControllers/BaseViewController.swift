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
    func viewModel(type: AnyClass) -> BaseViewModel?
}

class BaseViewController: UIViewController, ViewControllerBindable {
        
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.buildSubviews()
        self.buildLogic()
        // Do any additional setup after loading the view.
    }
    
    internal func buildSubviews() {
        
    }
    
    internal func buildLogic() {
        
    }
    
    // MARK: ViewControllerBindable
    var viewModels: [BaseViewModel]?
    
    func bind(to viewModels: [BaseViewModel]?) {
        self.viewModels = viewModels
    }
    
    func viewModel(type: AnyClass) -> BaseViewModel? {
        
        if let vm = self.viewModels?.first(where: { (vm) -> Bool in
            return String(describing: vm.self).components(separatedBy: ".").last! == String(describing: type)
        }){
            return vm
        }
        else{
            print("Could not find ViewModel of type: '\(String(describing: type))'")
            return nil
        }
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
