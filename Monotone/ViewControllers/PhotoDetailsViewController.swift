//
//  PhotoDetailsViewController.swift
//  
//
//  Created by Xueliang Chen on 2020/11/12.
//

import UIKit

import SnapKit
import RxSwift
import Kingfisher
import anim

class PhotoDetailsViewController: BaseViewController {
    
    // MARK: Priavte
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: Controls
    private var userCapsuleBtn: CapsuleButton!
    private var operationView: PhotoDetailsOperationView!
    private var scrollView: PhotoZoomableScrollView!
    
    private var likeCapsuleBtn: CapsuleButton!
    private var collectCapsuleBtn: CapsuleButton!
    private var expandBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.

    }
    
    override func buildSubviews() {
        self.view.backgroundColor = UIColor.black
        
        // navBar.
        self.navBarTransparent = true
        self.navBarHidden = true
                
        // scrollView.
        self.scrollView = PhotoZoomableScrollView()
        self.scrollView.maximumZoomScale = 10.0
        self.scrollView.minimumZoomScale = 1.0
        self.view.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints({ (make) in
            make.top.right.bottom.left.equalTo(self.view)
        })
        
        // userCapsuleBtn.
        self.userCapsuleBtn = CapsuleButton()
        self.userCapsuleBtn.setTitle("Terry Crews", for: .normal)
        self.userCapsuleBtn.setImage(UIImage(named: "details-btn-like"), for: .normal)
        self.userCapsuleBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        self.userCapsuleBtn.backgroundStyle = .normal
        self.userCapsuleBtn.backgroundColor = UIColor.clear
        self.view.addSubview(self.userCapsuleBtn)
        self.userCapsuleBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(17.0)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
        // operationView.
        self.operationView = PhotoDetailsOperationView()
        self.view.addSubview(self.operationView)
        self.operationView.snp.makeConstraints { (make) in
            make.right.equalTo(self.view)
            make.left.equalTo(self.userCapsuleBtn.snp.right)
            make.height.equalTo(30.0)
            make.centerY.equalTo(self.userCapsuleBtn)
        }
        
        // likeCapsuleBtn.
        self.likeCapsuleBtn = CapsuleButton()
        self.likeCapsuleBtn.setTitle("20", for: .normal)
        self.likeCapsuleBtn.setImage(UIImage(named: "details-btn-like"), for: .normal)
        self.likeCapsuleBtn.backgroundStyle = .blur
        self.view.addSubview(self.likeCapsuleBtn)
        self.likeCapsuleBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(17.0)
            make.bottom.equalTo(self.userCapsuleBtn.snp.top).offset(-26.0)
        }
        
        // collectCapsuleBtn.
        self.collectCapsuleBtn = CapsuleButton()
        self.collectCapsuleBtn.setTitle("Collect", for: .normal)
        self.collectCapsuleBtn.setImage(UIImage(named: "details-btn-collect"), for: .normal)
        self.collectCapsuleBtn.backgroundStyle = .blur
        self.view.addSubview(self.collectCapsuleBtn)
        self.collectCapsuleBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.likeCapsuleBtn.snp.right).offset(10.0)
            make.centerY.equalTo(self.likeCapsuleBtn)
        }
        
        // expandBtn.
        self.expandBtn = UIButton()
        self.expandBtn.setImage(UIImage(named: "details-btn-expand"), for: .normal)
        self.expandBtn.setImage(UIImage(named: "details-btn-collapse"), for: .selected)
        self.view.addSubview(self.expandBtn)
        self.expandBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self.view).offset(-17.0)
            make.centerY.equalTo(self.likeCapsuleBtn)
        }
        
    }
    
    override func buildLogic() {
                
        // ViewModel.
        let photoDetailsViewModel = self.viewModel(type:PhotoDetailsViewModel.self)!
        
        // scrollView.
        photoDetailsViewModel.output.photo.subscribe(onNext: { (photo) in
            self.scrollView.photo = photo
        })
        .disposed(by: self.disposeBag)
        
        // operationView.
        self.operationView.infoBtn.rx.tap
            .subscribe(onNext: { _ in
                let photo = photoDetailsViewModel.output.photo.value

                let args = [
                    "photo" : photo
                ]

                self.transition(type: .present(.photoInfo(args), .fullScreen), with: nil)
//                self.transition(type: .push(.photoInfo(args)), with: nil)
            })
            .disposed(by: self.disposeBag)
        
        // expandBtn.
        self.expandBtn.rx.tap
            .subscribe(onNext: { _ in
                self.expandBtn.isSelected = !self.expandBtn.isSelected
                
                self.animation(animationState: self.expandBtn.isSelected ? .expanded: .normal)
                self.scrollView.adjustZoomScale(scaleToFill: self.expandBtn.isSelected, animated: true)
            })
            .disposed(by: self.disposeBag)
        
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

extension PhotoDetailsViewController: ViewControllerAnimatable{
    enum AnimationState{
        case normal
        case expanded
    }
    
    func animation(animationState: AnimationState) {
        switch animationState {
        case .normal:
            
            anim { (animSettings) -> (animClosure) in
                animSettings.duration = 0.5
                animSettings.ease = .easeInOutQuart
                
                return {
                    self.likeCapsuleBtn.alpha = 1.0
                    self.collectCapsuleBtn.alpha = 1.0
                }
            }
            
            anim(constraintParent: self.view) { (animSettings) -> animClosure in
                animSettings.duration = 0.5
                animSettings.ease = .easeInOutQuart
                
                return {
                    self.expandBtn.snp.remakeConstraints { (make) in
                        make.right.equalTo(self.view).offset(-17.0)
                        make.centerY.equalTo(self.likeCapsuleBtn)
                    }
                    
                    self.operationView.snp.remakeConstraints { (make) in
                        make.left.right.equalTo(self.view)
                        make.height.equalTo(30.0)
                        make.centerY.equalTo(self.userCapsuleBtn)
                    }
                }
            }
            
            
            break
        case .expanded:
            
            anim { (animSettings) -> (animClosure) in
                animSettings.duration = 0.5
                animSettings.ease = .easeInOutQuart
                
                return {
                    self.likeCapsuleBtn.alpha = 0
                    self.collectCapsuleBtn.alpha = 0
                }
            }
            
            anim(constraintParent: self.view) { (animSettings) -> animClosure in
                animSettings.duration = 0.5
                animSettings.ease = .easeInOutQuart
                
                return {
                    self.expandBtn.snp.remakeConstraints { (make) in
                        make.right.equalTo(self.view).offset(-17.0)
                        make.centerY.equalTo(self.userCapsuleBtn)
                    }
                    
                    self.operationView.snp.remakeConstraints { (make) in
                        make.left.right.equalTo(self.view)
                        make.height.equalTo(30.0)
                        make.bottom.equalTo(self.view.snp.bottom).offset(self.operationView.frame.size.height)
                    }
                }
            }
            
            break

        }
    }
}
