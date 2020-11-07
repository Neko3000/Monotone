//
//  ViewController.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/10/29.
//

import UIKit
import SnapKit

import SwiftyJSON

class LoginViewController: MTViewController {
    
    private var logoImageView : UIImageView?
    private var facebookLoginBtn : UIButton?
    private var orLabel : UILabel?
    private var usernameTextField : UITextField?
    private var passwordTextField : UITextField?
    private var loginBtn : UIButton?
    private var forgetPasswordBtn : UIButton?
    
    private var centerView : UIView?
    private var noAccountLabel : UILabel?
    private var registerBtn : UIButton?
    
    convenience init() {
        self.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func buildSubviews() {
        
        // usernameTextField.
        self.usernameTextField = UITextField()
        self.usernameTextField!.placeholder = "Username or email"
        self.usernameTextField!.textColor = MTColorPalette.colorGrayLight
        self.usernameTextField!.font = UIFont.systemFont(ofSize: 14)
        self.usernameTextField!.textAlignment = .center
        self.usernameTextField!.backgroundColor = MTColorPalette.colorGrayLighter
        self.usernameTextField!.layer.cornerRadius = 20.0
        self.usernameTextField!.layer.masksToBounds = true
        self.view.addSubview(self.usernameTextField!)
        self.usernameTextField!.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(34.0)
            make.right.equalTo(self.view).offset(-34.0)
            make.height.equalTo(40.0)
            make.bottom.equalTo(self.view.snp.centerY).offset(-10.0)
        }
        
        // passwordTextField.
        self.passwordTextField = UITextField()
        self.passwordTextField!.placeholder = "Password"
        self.passwordTextField!.textColor = MTColorPalette.colorGrayLight
        self.passwordTextField!.font = UIFont.systemFont(ofSize: 14)
        self.passwordTextField!.textAlignment = .center
        self.passwordTextField!.backgroundColor = MTColorPalette.colorGrayLighter
        self.passwordTextField!.layer.cornerRadius = 20.0
        self.passwordTextField!.layer.masksToBounds = true
        self.view.addSubview(self.passwordTextField!)
        self.passwordTextField!.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(34.0)
            make.right.equalTo(self.view).offset(-34.0)
            make.height.equalTo(40.0)
            make.top.equalTo(self.view.snp.centerY).offset(10.0)
        }
        
        // orLabel.
        self.orLabel = UILabel()
        self.orLabel!.text = "or";
        self.orLabel!.textColor = MTColorPalette.colorGrayLight
        self.orLabel!.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(self.orLabel!)
        self.orLabel!.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.usernameTextField!.snp.top).offset(-8)
            make.centerX.equalTo(self.view)
        }
        
        // facebookLoginBtn.
        self.facebookLoginBtn = UIButton()
        self.facebookLoginBtn!.setTitle("Login with Facebook", for: .normal)
        self.facebookLoginBtn!.setTitleColor(UIColor.white, for: .normal)
        self.facebookLoginBtn!.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.facebookLoginBtn!.backgroundColor = MTColorPalette.colorDenim
        self.facebookLoginBtn!.layer.cornerRadius = 24.0
        self.facebookLoginBtn!.layer.masksToBounds = true
        self.view.addSubview(self.facebookLoginBtn!)
        self.facebookLoginBtn!.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(34.0)
            make.right.equalTo(self.view).offset(-34.0)
            make.height.equalTo(48.0)
            make.bottom.equalTo(self.orLabel!.snp.top).offset(-8.0)
        }
        
        // logoImageView.
        self.logoImageView = UIImageView()
        self.logoImageView!.image = UIImage(named: "unsplash-logo")
        self.view.addSubview(self.logoImageView!)
        self.logoImageView!.snp.makeConstraints { (make) in
            make.width.height.equalTo(44.0);
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(self.facebookLoginBtn!.snp.top).offset(-48.0)
        }
        
        // loginBtn.
        self.loginBtn = UIButton()
        self.loginBtn!.setTitle("Login", for: .normal)
        self.loginBtn!.setTitleColor(UIColor.white, for: .normal)
        self.loginBtn!.backgroundColor = UIColor.black
        self.loginBtn!.layer.cornerRadius = 24.0
        self.loginBtn!.layer.masksToBounds = true
        self.view.addSubview(self.loginBtn!)
        self.loginBtn!.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(34.0)
            make.right.equalTo(self.view).offset(-34.0)
            make.height.equalTo(48.0)
            make.top.equalTo(self.passwordTextField!.snp.bottom).offset(25.0)
        }
        
        // forgetPasswordBtn.
        self.forgetPasswordBtn = UIButton()
        self.forgetPasswordBtn!.setTitle("Forgot Password?", for: .normal)
        self.forgetPasswordBtn!.setTitleColor(MTColorPalette.colorGrayLight, for: .normal)
        self.forgetPasswordBtn!.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.forgetPasswordBtn!.backgroundColor = UIColor.clear
        self.view.addSubview(self.forgetPasswordBtn!)
        self.forgetPasswordBtn!.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.loginBtn!.snp.bottom).offset(24.0)
        }
        
        // centerView
        self.centerView = UIView()
        self.view.addSubview(self.centerView!)
        self.centerView!.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.forgetPasswordBtn!.snp.bottom).offset(17.0)
        }
        
        // noAccountLabel.
        self.noAccountLabel = UILabel()
        self.noAccountLabel!.text = "Don't have an account?";
        self.noAccountLabel!.textColor = MTColorPalette.colorGrayLight
        self.noAccountLabel!.font = UIFont.systemFont(ofSize: 14)
        self.centerView!.addSubview(self.noAccountLabel!)
        self.noAccountLabel!.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(self.centerView!)
            make.height.equalTo(18.0)
        }
        
        // registerBtn.
        self.registerBtn = UIButton()
        self.registerBtn!.setTitle("Join", for: .normal)
        self.registerBtn!.setTitleColor(UIColor.black, for: .normal)
        self.registerBtn!.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.registerBtn!.backgroundColor = UIColor.clear
        self.view.addSubview(self.registerBtn!)
        self.registerBtn!.snp.makeConstraints { (make) in
            make.top.right.bottom.equalTo(self.centerView!)
            make.left.equalTo(self.noAccountLabel!.snp.right).offset(3.0)
            make.height.equalTo(18.0)
        }
                
        let request = SearchPhotosRequest()
        MTNetworkManager.shared.request(request: request, method: MTHTTPMethod.get,success: { (result:JSON) in
            print("success")
        }, fail: { (error:JSON) in
            print("error")
        })

//        MTNetworkManager.shared.sendRequest(request: request, method: MTHTTPMethod.get, success:{
//            (request:MTBaseRequest) -> Void in
//        }, fail: {
//            (error:Error) -> Void in
//        } )
        
    }
}

