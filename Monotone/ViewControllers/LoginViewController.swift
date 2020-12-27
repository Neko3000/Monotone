//
//  ViewController.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/10/29.
//

import UIKit
import SnapKit
import NVActivityIndicatorView

import RxSwift
import RxCocoa
import Action
import RxSwiftExt

// MARK: - LoginViewController
class LoginViewController: BaseViewController {
    
    // MARK: - Controls
    private var logoImageView : UIImageView!
    private var titleLabel : UILabel!
    private var descriptionLabel : UILabel!
    private var loginBtn : UIButton!
    private var activityIndicatorView: NVActivityIndicatorView!
    
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
        
        // DescriptionLabel.
        let attributedDescription = NSMutableAttributedString(string: NSLocalizedString("unsplash_login_description", comment: "Explore those Impressive photos which created by\nmost creative Maestros all over the World."))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2.0
        
        attributedDescription.addAttribute(NSAttributedString.Key.paragraphStyle,value: paragraphStyle, range: NSMakeRange(0, attributedDescription.length))
        
        self.descriptionLabel = UILabel()
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 12)
        self.descriptionLabel.textColor = ColorPalette.colorGrayNormal
        self.descriptionLabel.attributedText = attributedDescription
        self.descriptionLabel.textAlignment = .center
        self.descriptionLabel.numberOfLines = 0
        self.view.addSubview(self.descriptionLabel)
        self.descriptionLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(self.view.snp.centerY).offset(-20.0)
            make.left.greaterThanOrEqualTo(self.view).offset(20.0)
            make.right.lessThanOrEqualTo(self.view).offset(-20.0)
        }
        
        // TitleLabel.
        self.titleLabel = UILabel()
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        self.titleLabel.textColor = ColorPalette.colorBlack
        self.titleLabel.text = "Monotone."
        self.view.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(self.descriptionLabel.snp.top).offset(-10.0)
        }
        
        // LogoImageView.
        self.logoImageView = UIImageView()
        self.logoImageView.tintColor = ColorPalette.colorBlack
        self.logoImageView.image = UIImage(named: "unsplash-logo")?.withRenderingMode(.alwaysTemplate)
        self.view.addSubview(self.logoImageView)
        self.logoImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(44.0);
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(self.titleLabel.snp.top).offset(-40.0)
            
        }
        
        // LoginBtn.
        self.loginBtn = UIButton()
        self.loginBtn.setTitle(NSLocalizedString("unsplash_login_sign_in_or_sign_up", comment: "Sign in / Sign up"), for: .normal)
        self.loginBtn.setTitleColor(ColorPalette.colorWhite, for: .normal)
        self.loginBtn.backgroundColor = ColorPalette.colorBlack
        self.loginBtn.layer.cornerRadius = 24.0
        self.loginBtn.layer.masksToBounds = true
        self.view.addSubview(self.loginBtn)
        self.loginBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(34.0)
            make.right.equalTo(self.view).offset(-34.0)
            make.height.equalTo(48.0)
            make.top.equalTo(self.view.snp.centerY).offset(20.0)
        }
        
        // ActivityIndicatorView
        self.activityIndicatorView = NVActivityIndicatorView(frame: CGRect.zero)
        self.activityIndicatorView.type = .circleStrokeSpin
        self.activityIndicatorView.color = ColorPalette.colorBlack
        self.view.addSubview(self.activityIndicatorView)
        self.activityIndicatorView.snp.makeConstraints { (make) in
            make.top.equalTo(self.loginBtn.snp.bottom).offset(20.0)
            make.width.height.equalTo(20.0)
            make.centerX.equalTo(self.loginBtn)
        }
        
        // TODO: Privacy Information: we use you ...
    }
    
    override func buildLogic() {
        super.buildLogic()
        
        // ViewModel.
        let loginViewModel = self.viewModel(type: LoginViewModel.self)!
        
        // Bindings.
        // LoginBtn.
        self.loginBtn.rx.tap
            .subscribe(onNext: { (_) in
                loginViewModel.input.loginAction?.execute()
            })
            .disposed(by: self.disposeBag)
        
        // Logging.
        loginViewModel.output.logging
            .subscribe(onNext:{ [weak self] (logging) in
                guard let self = self else { return }
                
                if(logging){
                    self.loginBtn.isHidden = true
                    
                    self.activityIndicatorView.isHidden = false
                    self.activityIndicatorView.startAnimating()
                }
                else{
                    self.loginBtn.isHidden = false
                    
                    self.activityIndicatorView.isHidden = true
                    self.activityIndicatorView.stopAnimating()
                }

            })
            .disposed(by: self.disposeBag)
        
        // LoggedIn.
        loginViewModel.output.loggedIn
            .ignore(false)
            .subscribe(onNext:{ (_) in
                // SceneCoordinator.shared.transition(type: .root(.home), with: nil)
                SceneCoordinator.shared.transition(type: .root(.sideMenu), with: nil)
            })
            .disposed(by: self.disposeBag)
        
        // 
        // If there's local credential, update current user information automatically.
        if(AuthManager.shared.credential != nil){
            loginViewModel.input.updateUserAction?.execute()
        }
    }
}

