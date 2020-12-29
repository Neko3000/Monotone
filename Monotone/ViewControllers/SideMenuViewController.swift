//
//  SideMenuViewController.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/18.
//

import UIKit

import RxSwift
import Kingfisher

// MARK: - SideMenuViewController
class SideMenuViewController: BaseViewController {
    
    // MARK: - Controls
    private var profileView: SideMenuProfileView!
    private var pageView: SideMenuPageView!
    
    private var unsplashLabel: UILabel!
    
    // MARK: - Private
    private let disposeBag: DisposeBag = DisposeBag()
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func buildSubviews() {
        self.view.backgroundColor = UIColor.white
        
        // UnsplashLabel
        self.unsplashLabel = UILabel()
        self.unsplashLabel.textColor = ColorPalette.colorGrayLighter
        self.unsplashLabel.font = UIFont.boldSystemFont(ofSize: 180)
        self.unsplashLabel.text = NSLocalizedString("unsplash_upper_case", comment: "UNSPLASH")
        self.unsplashLabel.transform = CGAffineTransform(rotationAngle: .pi / -2.0)
        self.view.addSubview(self.unsplashLabel)
        self.unsplashLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.view)
            make.centerX.equalTo(self.view.snp.right).offset(-70.0)
        }
        
        // ProfileView.
        self.profileView = SideMenuProfileView()
        self.view.addSubview(self.profileView)
        self.profileView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(18.0)
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(42.0)
        }
        
        // PageView.
        self.pageView = SideMenuPageView()
        self.view.addSubview(self.pageView)
        self.pageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.profileView.snp.bottom).offset(30.0)
            make.left.equalTo(self.view).offset(18.0)
            make.right.equalTo(self.view).offset(-18.0)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-42.0)
        }
    }
    
    override func buildLogic() {
        
        // ViewModel.
        let sideMenuViewModel = self.viewModel(type: SideMenuViewModel.self)!
        
        // Bindings.
        // Pages.
        sideMenuViewModel.output.pages
            .bind(to: self.pageView.pages)
            .disposed(by: self.disposeBag)
                
        // CurrentUser.
        sideMenuViewModel.output.currentUser
            .bind(to: self.profileView.user)
            .disposed(by: self.disposeBag)
        
        // Collections.
        sideMenuViewModel.output.collections
            .bind(to: self.profileView.collections)
            .disposed(by: self.disposeBag)
        
        // LikedPhotos.
        sideMenuViewModel.output.likedPhotos
            .bind(to: self.profileView.photos)
            .disposed(by: self.disposeBag)
        
        // Pages.
        sideMenuViewModel.input.pages.accept(SideMenuPageVars.pages)
        
        // SelectedPage.
        pageView.selectedPage
            .unwrap()
            .subscribe(onNext: { (keyValuePair) in
                
                switch keyValuePair.key{
                case .myPhotos:
                    SceneCoordinator.shared.transition(type: .present(scene: .myPhotos, warpped: true),
                                                       with: nil,
                                                       animated: true)
                    break
                    
                case .hiring:
                    break
                    
                case .licenses:
                    break
                    
                case .help:
                    break
                    
                case .madeWithUnsplash:
                    break
                }
            })
            .disposed(by: self.disposeBag)
        
    }
    
}
