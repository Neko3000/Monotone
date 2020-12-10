//
//  ViewController.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/10/29.
//

import UIKit
import SnapKit

import RxSwift
import RxCocoa
import Action

// MARK: LoginViewController
class LoginViewController: BaseViewController {
    
    // MARK: - Controls
    private var logoImageView : UIImageView!
    private var titleLabel : UILabel!
    private var descriptionLabel : UILabel!
    private var loginBtn : UIButton!
    
    // MARK: - Private
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func buildSubviews() {
        super.buildSubviews()
        
        self.view.backgroundColor = ColorPalette.colorWhite
        
        // descriptionLabel.
        self.descriptionLabel = UILabel()
        self.descriptionLabel.textColor = ColorPalette.colorBlack
        self.descriptionLabel.text = "Explore those Impressive photos which created by\nmost creative Maestros all over the World."
        self.descriptionLabel.numberOfLines = 0
        self.view.addSubview(self.descriptionLabel)
        self.descriptionLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(self.view.snp.centerY).offset(-20.0)
        }
        
        // titleLabel.
        self.titleLabel = UILabel()
        self.titleLabel.textColor = ColorPalette.colorBlack
        self.titleLabel.text = "Monotone"
        self.view.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(self.descriptionLabel.snp.top).offset(-10.0)
        }
        
        // logoImageView.
        self.logoImageView = UIImageView()
        self.logoImageView.tintColor = ColorPalette.colorBlack
        self.logoImageView.image = UIImage(named: "unsplash-logo")?.withRenderingMode(.alwaysTemplate)
        self.view.addSubview(self.logoImageView)
        self.logoImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(44.0);
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(self.titleLabel.snp.top).offset(-10.0)
        }
        
        // loginBtn.
        self.loginBtn = UIButton()
        self.loginBtn.setTitle("Login", for: .normal)
        self.loginBtn.setTitleColor(ColorPalette.colorWhite, for: .normal)
        self.loginBtn.backgroundColor = ColorPalette.colorBlack
        self.loginBtn.layer.cornerRadius = 24.0
        self.loginBtn.layer.masksToBounds = true
        self.view.addSubview(self.loginBtn)
        self.loginBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(34.0)
            make.right.equalTo(self.view).offset(-34.0)
            make.height.equalTo(48.0)
            make.top.equalTo(self.view.snp.centerY).offset(30.0)
        }
    }
    
    override func buildLogic() {
        super.buildLogic()
        
        // ViewModel.
        let loginViewModel = self.viewModel(type: LoginViewModel.self)!
        
        // Bindings.
        self.loginBtn.rx.tap.subscribe(onNext: { _ in
            loginViewModel.input.loginAction.execute()
        })
        .disposed(by: self.disposeBag)
    }
}

