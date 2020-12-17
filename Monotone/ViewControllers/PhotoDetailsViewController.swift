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

// MARK: PhotoDetailsViewController
class PhotoDetailsViewController: BaseViewController {

    // MARK: - Controls
    private var avatarImageView: UIImageView!
    private var usernameLabel: UILabel!
    private var userCapsuleView: CapsuleView!
    
    private var operationView: PhotoDetailsOperationView!
    private var scrollView: PhotoZoomableScrollView!
    
    private var likeCapsuleBtn: CapsuleButton!
    private var collectCapsuleBtn: CapsuleButton!
    private var expandBtn: UIButton!
    
    // MARK: - ViewControllers
    private var photoInfoViewController: PhotoInfoViewController!
    private var photoShareViewController: PhotoShareViewController!
    
    // MARK: - Priavte
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.

    }
    
    override func buildSubviews() {
        self.view.backgroundColor = UIColor.black
        
        // navBar.
        self.navBarTransparent = true
        // self.navBarHidden = true
        self.navBarItemsColor = UIColor.white
                
        // scrollView.
        self.scrollView = PhotoZoomableScrollView()
        self.scrollView.maximumZoomScale = 10.0
        self.scrollView.minimumZoomScale = 1.0
        self.view.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints({ (make) in
            make.top.right.bottom.left.equalTo(self.view)
        })
        
        // ImageView in userCapsuleView.
        self.avatarImageView = UIImageView()
        self.avatarImageView.layer.cornerRadius = 14.0
        self.avatarImageView.layer.masksToBounds = true
        self.avatarImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(27.0)
        }
        
        self.usernameLabel = UILabel()
        self.usernameLabel.font = UIFont.systemFont(ofSize: 12.0)
        self.usernameLabel.textColor = UIColor.white
        
        // userCapsuleView.
        self.userCapsuleView = CapsuleView()
        self.userCapsuleView.views = [avatarImageView, usernameLabel]
        self.view.addSubview(self.userCapsuleView)
        self.userCapsuleView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(17.0)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
        // operationView.
        self.operationView = PhotoDetailsOperationView()
        self.view.addSubview(self.operationView)
        self.operationView.snp.makeConstraints { (make) in
            make.right.equalTo(self.view)
            make.left.equalTo(self.userCapsuleView.snp.right)
            make.height.equalTo(30.0)
            make.centerY.equalTo(self.userCapsuleView)
        }
        
        // likeCapsuleBtn.
        self.likeCapsuleBtn = CapsuleButton()
        self.likeCapsuleBtn.setTitle("20", for: .normal)
        self.likeCapsuleBtn.setImage(UIImage(named: "details-btn-like"), for: .selected)
        self.likeCapsuleBtn.setImage(UIImage(named: "details-btn-unlike"), for: .normal)
        self.likeCapsuleBtn.backgroundStyle = .blur
        self.view.addSubview(self.likeCapsuleBtn)
        self.likeCapsuleBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(17.0)
            make.bottom.equalTo(self.userCapsuleView.snp.top).offset(-26.0)
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
        photoDetailsViewModel.output.photo
            .unwrap()
            .subscribe(onNext: { [weak self] (photo) in
                guard let self = self else { return }

                self.scrollView.photo = photo
                
                self.likeCapsuleBtn.setTitle("\(photo.likes ?? 0)", for: .normal)
                self.likeCapsuleBtn.isSelected = photo.likedByUser ?? false
                
                let profileImage = photo.sponsorship?.sponsor?.profileImage?.medium ?? ( photo.user?.profileImage?.medium ?? "" )
                self.avatarImageView.kf.setImage(with: URL(string: profileImage),
                                                 placeholder: UIImage(),
                                                 options: [.transition(.fade(0.7)),
                                                          .originalCache(.default)])
                
                let username = photo.sponsorship?.sponsor?.username ?? (photo.user?.username ?? "" )
                self.usernameLabel.text = username
            })
            .disposed(by: self.disposeBag)
                        
        // operationView.
        self.operationView.infoBtn.rx.tap
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }

                let photo = photoDetailsViewModel.output.photo.value

                let args = [
                    "photo" : photo
                ] as [String : Any?]

                self.transition(type: .present(.photoInfo(args), .pageSheet), with: nil, animated: true)
//                self.transition(type: .push(.photoInfo(args)), with: nil)
            })
            .disposed(by: self.disposeBag)
        
        // shareBtn.
        self.operationView.shareBtn.rx.tap
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                
                let photo = photoDetailsViewModel.output.photo.value

                let args = [
                    "photo" : photo
                ] as [String : Any?]

                self.transition(type: .present(.photoShare(args), .pageSheet), with: nil, animated: true)
            })
            .disposed(by: self.disposeBag)
        
        // likeCapsuleBtn.
        self.likeCapsuleBtn.rx.tap
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                
                if(self.likeCapsuleBtn.isSelected){
                    photoDetailsViewModel.input.unlikePhotoAction?.execute()
                }
                else{
                    photoDetailsViewModel.input.likePhotoAction?.execute()
                }
            })
            .disposed(by: self.disposeBag)
        
        // collectCapsuleBtn.
        self.collectCapsuleBtn.rx.tap
            .subscribe(onNext: { [weak self ] (_) in
//                let username = photoDetailsViewModel.output.photo.value.user?.username

                let args = [
                    "username" : "neko3000",
                    "photo": photoDetailsViewModel.output.photo.value
                ] as [String : Any?]

                self?.transition(type: .present(.photoAddToCollection(args), .pageSheet), with: nil, animated: true)
            })
            .disposed(by: self.disposeBag)
        
        // expandBtn.
        self.expandBtn.rx.tap
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                
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

// MARK: - ViewControllerAnimatable
extension PhotoDetailsViewController: ViewControllerAnimatable{
    
    // MARK: - Enums
    enum AnimationState{
        case normal
        case expanded
    }
    
    // MARK: - Animation
    func animation(animationState: AnimationState) {
        switch animationState {
        case .normal:
            
            self.userCapsuleView.backgroundStyle = .normal
            
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
                        make.centerY.equalTo(self.userCapsuleView)
                    }
                }
            }
            
            
            break
        case .expanded:
            
            self.userCapsuleView.backgroundStyle = .blur

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
                        make.centerY.equalTo(self.userCapsuleView)
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
