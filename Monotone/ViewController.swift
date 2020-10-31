//
//  ViewController.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/10/29.
//

import UIKit
import SnapKit

class ViewController: MTViewController {
    
    private var logoImageView : UIImageView?
    private var facebookLoginBtn : UIButton?
    private var usernameTextField : UITextField?
    private var passwordTextField : UITextField?
    private var loginBtn : UIButton?
    private var forgetPasswordBtn : UIButton?
    private var registerBtn : UIButton?
    
    convenience init() {
        self.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func buildSubviews() {
        // Username.
        self.usernameTextField = UITextField()
        self.usernameTextField!.text = "Username or email"
        self.usernameTextField!.backgroundColor = UIColor.lightGray
        self.usernameTextField!.layer.cornerRadius = 50.0
        self.usernameTextField!.layer.masksToBounds = true
        self.view.addSubview(self.usernameTextField!)
        self.usernameTextField!.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(34.0)
            make.right.equalTo(self.view).offset(-34.0)
            make.height.equalTo(40.0)
            make.bottom.equalTo(self.view.snp.centerY).offset(-27.0)
        }
        
        
        // Logo.
//        self.logoImageView = UIImageView()
//        self.logoImageView!.image = UIImage(named: "unsplash-logo")
//        self.view.addSubview(self.logoImageView!)
//        self.logoImageView!.snp.makeConstraints { (make) in
//            make.width.height.equalTo(44.0);
//            // more
//        }
    }
}

