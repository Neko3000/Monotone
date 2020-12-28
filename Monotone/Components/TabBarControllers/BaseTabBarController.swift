//
//  BaseTabBarController.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/28.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.buildSubviews()
        self.buildLogic()
    }
    
    func buildSubviews() {
        // Implemented by subclass.
    }
    
    func buildLogic() {
        // Implemented by subclass.
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
