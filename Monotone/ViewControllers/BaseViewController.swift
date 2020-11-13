//
//  BaseViewController.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/10/30.
//

import UIKit
import RxSwift

protocol ViewControllerBindable{
    associatedtype ViewModelType
    var viewModel: ViewModelType? { get }
    
    func bind(to viewModel: ViewModelType)
}

class BaseViewController: UIViewController {
    
    // MARK: Variables
    //
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
