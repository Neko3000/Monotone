//
//  HomeViewController.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/27.
//

import UIKit

import RxSwift
import Kingfisher

import anim

// MARK: - HomeViewController
class HomeViewController: BaseViewController {
    
    // MARK: - Controls
    private var sideMenuViewController: SideMenuViewController!
    private var photoListViewController: PhotoListViewController!
    
    private var menuBtn: UIButton!
    
    // MARK: - Private
    private var swipeGestureRecognizer: UISwipeGestureRecognizer!
    
    private let disposeBag: DisposeBag = DisposeBag()
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func buildSubviews() {
        
        self.view.backgroundColor = ColorPalette.colorWhite
        
        // SideMenuViewController.
        self.sideMenuViewController = SideMenuViewController()
        self.sideMenuViewController.bind(to: [self.viewModel(type: SideMenuViewModel.self)!])
        self.addChild(self.sideMenuViewController)
        self.view.addSubview(self.sideMenuViewController.view)
        self.sideMenuViewController.view.snp.makeConstraints { (make) in
            make.width.height.equalTo(self.view)
            make.centerY.equalTo(self.view)
            make.right.equalTo(self.view.snp.left)
        }
        
        // PhotoListViewController.
        self.photoListViewController = PhotoListViewController()
        self.photoListViewController.bind(to: [self.viewModel(type: PhotoListViewModel.self)!])
        self.addChild(self.photoListViewController)
        self.photoListViewController.view.layer.applySketchShadow(color: ColorPalette.colorShadow, alpha: 1.0, x: -2, y: 0, blur: 20.0, spread: 0)
        self.view.addSubview(self.photoListViewController.view)
        self.photoListViewController.view.snp.makeConstraints { (make) in
            make.width.height.equalTo(self.view)
            make.centerY.equalTo(self.view)
            make.centerX.equalTo(self.view)
        }
        
        // SwipeGestureRecognizer.
        self.swipeGestureRecognizer = UISwipeGestureRecognizer()
        self.swipeGestureRecognizer.direction = .left
        self.view.addGestureRecognizer(self.swipeGestureRecognizer)
    }
    
    override func buildLogic() {
        
        // ViewModel.
        
        // Bindings.
        // SwipeGestureRecognizer.
        self.swipeGestureRecognizer.rx.event
            .subscribe(onNext: { [weak self] recognizer in
                guard let self = self else { return }
                
                self.animation(animationState: .showPhotoList)
            })
            .disposed(by: disposeBag)
        
        //
        self.photoListViewController.menuBtnPressed
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                self.animation(animationState: .showSideMenu)
            })
            .disposed(by: disposeBag)
    }
    
}

// MARK: - ViewControllerAnimatable
extension HomeViewController: ViewControllerAnimatable{
    
    // MARK: - Enums
    enum AnimationState {
        case showPhotoList
        case showSideMenu
    }
        
    // MARK: - Animation
    // Animation for PhotoListViewController & SideMenuViewController
    func animation(animationState: AnimationState) {
        switch animationState {
        case .showPhotoList:
            
            anim { (animSettings) -> (animClosure) in
                animSettings.duration = 0.5
                animSettings.ease = .easeInOutQuart
                
                return {
                    self.photoListViewController.view.transform = CGAffineTransform.identity
                }
            }
            
            anim(constraintParent: self.view) { (animSettings) -> animClosure in
                animSettings.duration = 0.5
                animSettings.ease = .easeInOutQuart
                
                return {
                    self.sideMenuViewController.view.snp.remakeConstraints({ (make) in
                        make.width.height.equalTo(self.view)
                        make.centerY.equalTo(self.view)
                        make.right.equalTo(self.view.snp.left)
                    })
                    
                    self.photoListViewController.view.snp.remakeConstraints { (make) in
                        make.width.height.equalTo(self.view)
                        make.centerY.equalTo(self.view)
                        make.centerX.equalTo(self.view)
                    }
                }
            }
            
            break
        case .showSideMenu:
            
            anim { (animSettings) -> (animClosure) in
                animSettings.duration = 0.5
                animSettings.ease = .easeInOutQuart
                
                return {
                    self.photoListViewController.view.transform = CGAffineTransform.identity.scaledBy(x: 0.8, y: 0.8)
                }
            }
            
            anim(constraintParent: self.view) { (animSettings) -> animClosure in
                animSettings.duration = 0.5
                animSettings.ease = .easeInOutQuart
                
                return {
                    self.sideMenuViewController.view.snp.remakeConstraints({ (make) in
                        make.width.height.equalTo(self.view)
                        make.centerY.equalTo(self.view)
                        make.centerX.equalTo(self.view)
                    })
                    
                    self.photoListViewController.view.snp.remakeConstraints { (make) in
                        make.width.height.equalTo(self.view)
                        make.centerY.equalTo(self.view)
                        make.left.equalTo(self.view.snp.right).multipliedBy(4.0/5)
                    }
                }
            }
            
            break
        }
    }
}
