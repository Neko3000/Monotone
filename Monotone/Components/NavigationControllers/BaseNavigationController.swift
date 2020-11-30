//
//  BaseNavigationController.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/12.
//

import UIKit

class BaseNavigationController: UINavigationController {

    // MARK: Variables
    //
        
    // MARK: LifeCycle
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
    
    // MARK: Nav
    func updateNavBarTransparent(transparent: Bool) {
        
    }
    
    func updateNavBarHidden(hidden: Bool) {
        
    }
    
    func updateNavItems() {
        
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
