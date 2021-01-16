//
//  StoreDetailsViewController.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/1/15.
//

import UIKit

import SnapKit
import MJRefresh

import RxSwift
import RxRelay
import RxSwiftExt

import RxDataSources

// MARK: - StoreDetailsViewController
class StoreDetailsViewController: BaseViewController {
    
    // MARK: - Public

    
    // MARK: - Controls
    private var scrollView: UIScrollView!
    private var containerView: UIView!
    
    private var titleLabel: UILabel!
    private var usernameLabel: UILabel!
    
    private var photoAImageView: UIImageView!
    private var photoBImageView: UIImageView!
    private var photoCImageView: UIImageView!
    private var photoDImageView: UIImageView!
    private var photoImageViews: [UIImageView] = [UIImageView]()
    
    private var priceLabel: UILabel!
    private var nameLabel: UILabel!
    
    private var propertyView: StoreDetailsPropertyView!
    private var addToCartBtn: UIButton!
    
    private var descriptionLabel: UILabel!
    
    // MARK: - Priavte
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func buildSubviews() {
        
        //
        self.view.backgroundColor = ColorPalette.colorWhite
        
        // ScrollView.
        self.scrollView = UIScrollView()
        self.view.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.right.left.equalTo(self.view)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        // ContainerView.
        self.containerView = UIView()
        self.scrollView.addSubview(self.containerView)
        self.containerView.snp.makeConstraints { (make) in
            make.width.equalTo(self.scrollView)
            make.top.right.bottom.left.equalTo(self.scrollView)
        }
        
        // TitleLabel.
        self.titleLabel = UILabel()
        self.titleLabel.textColor = ColorPalette.colorBlack
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 26)
        self.titleLabel.text = "Limited Edition: The Urban Explorer Sweatshirt"
        self.titleLabel.numberOfLines = 0
        self.containerView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(self.containerView)
            make.left.equalTo(self.containerView).offset(17.0)
            make.right.equalTo(self.containerView).offset(-56.0)
        })
        
        // UsernameLabel.
        self.usernameLabel = UILabel()
        self.usernameLabel.textColor = ColorPalette.colorGrayHeavy
        self.usernameLabel.font = UIFont.systemFont(ofSize: 14)
        self.usernameLabel.text = "By Unsplash x van Sc"
        self.usernameLabel.numberOfLines = 0
        self.containerView.addSubview(self.usernameLabel)
        self.usernameLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(5.0)
            make.left.equalTo(self.containerView).offset(17.0)
            make.right.equalTo(self.containerView).offset(-56.0)
        })

        // PhotoAImageView
        self.photoAImageView = UIImageView()
        self.photoImageViews.append(self.photoAImageView)
        self.photoAImageView.contentMode = .scaleAspectFill
        self.photoAImageView.backgroundColor = ColorPalette.colorGrayLighter
        self.photoAImageView.layer.masksToBounds = true
        self.containerView.addSubview(self.photoAImageView)
        self.photoAImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.containerView).offset(20.0)
            make.top.equalTo(self.usernameLabel.snp.bottom).offset(20.0)
            make.width.equalTo(self.containerView).multipliedBy(1.0/2)
            make.height.equalTo(302.0)
        }
        
        // PhotoBImageView
        self.photoBImageView = UIImageView()
        self.photoImageViews.append(self.photoBImageView)
        self.photoBImageView.contentMode = .scaleAspectFill
        self.photoBImageView.backgroundColor = ColorPalette.colorGrayLighter
        self.photoBImageView.layer.masksToBounds = true
        self.containerView.addSubview(self.photoBImageView)
        self.photoBImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.photoAImageView)
            make.left.equalTo(self.photoAImageView.snp.right).offset(20.0)
            make.right.equalTo(self.containerView).offset(-20.0)
            make.height.equalTo(87.0)
        }
        
        // PhotoCImageView
        self.photoCImageView = UIImageView()
        self.photoImageViews.append(self.photoCImageView)
        self.photoCImageView.contentMode = .scaleAspectFill
        self.photoCImageView.backgroundColor = ColorPalette.colorGrayLighter
        self.photoCImageView.layer.masksToBounds = true
        self.containerView.addSubview(self.photoCImageView)
        self.photoCImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.photoBImageView.snp.bottom).offset(20.0)
            make.left.equalTo(self.photoAImageView.snp.right).offset(20.0)
            make.right.equalTo(self.containerView).offset(-20.0)
            make.height.equalTo(87.0)
        }
        
        // PhotoDImageView
        self.photoDImageView = UIImageView()
        self.photoImageViews.append(self.photoDImageView)
        self.photoDImageView.contentMode = .scaleAspectFill
        self.photoDImageView.backgroundColor = ColorPalette.colorGrayLighter
        self.photoDImageView.layer.masksToBounds = true
        self.containerView.addSubview(self.photoDImageView)
        self.photoDImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.photoCImageView.snp.bottom).offset(20.0)
            make.left.equalTo(self.photoAImageView.snp.right).offset(20.0)
            make.right.equalTo(self.containerView).offset(-20.0)
            make.height.equalTo(87.0)
        }
        
        // PriceLabel.
        self.priceLabel = UILabel()
        self.priceLabel.textColor = ColorPalette.colorBlack
        self.priceLabel.font = UIFont.boldSystemFont(ofSize: 30)
        self.priceLabel.text = "$95.00"
        self.containerView.addSubview(self.priceLabel)
        self.priceLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(self.photoAImageView.snp.bottom).offset(18.0)
            make.left.equalTo(self.photoAImageView)
        })
        
        // NameLabel.
        self.nameLabel = UILabel()
        self.nameLabel.textColor = ColorPalette.colorGrayHeavy
        self.nameLabel.font = UIFont.systemFont(ofSize: 10)
        self.nameLabel.text = "The Urban Explorer Sweatshirt"
        self.containerView.addSubview(self.nameLabel)
        self.nameLabel.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self.priceLabel)
            make.right.equalTo(self.containerView).offset(-20.0)
        })

        // PropertyView.
        self.propertyView = StoreDetailsPropertyView()
        self.containerView.addSubview(self.propertyView)
        self.propertyView.snp.makeConstraints({ (make) in
            make.top.equalTo(self.priceLabel.snp.bottom).offset(18.0)
            make.left.equalTo(self.containerView).offset(20.0)
            make.right.equalTo(self.containerView).offset(-20.0)
            make.height.equalTo(63.0)
        })
        
        // AddToCartBtn.
        self.addToCartBtn = UIButton()
        self.addToCartBtn.backgroundColor = ColorPalette.colorBlack
        self.addToCartBtn.contentEdgeInsets = UIEdgeInsets(top: 14.0, left: 47.0, bottom: 14.0, right: 47.0)
        self.addToCartBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        self.addToCartBtn.setTitleColor(ColorPalette.colorWhite, for: .normal)
        self.addToCartBtn.setTitle("Add to Cart", for: .normal)
        self.addToCartBtn.layer.cornerRadius = 4.0
        self.addToCartBtn.layer.masksToBounds = true
        self.containerView.addSubview(self.addToCartBtn)
        self.addToCartBtn.snp.makeConstraints({ (make) in
            make.top.equalTo(self.propertyView.snp.bottom).offset(18.0)
            make.left.equalTo(self.containerView).offset(20.0)
        })
        
        // DescriptionLabel.
        self.descriptionLabel = UILabel()
        self.descriptionLabel.textColor = ColorPalette.colorGrayHeavy
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        self.descriptionLabel.numberOfLines = 0
        self.containerView.addSubview(self.descriptionLabel)
        self.descriptionLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(self.addToCartBtn.snp.bottom).offset(35.0)
            make.left.equalTo(self.containerView).offset(20.0)
            make.right.equalTo(self.containerView).offset(-20.0)
            make.bottom.equalTo(self.containerView).offset(-20.0)
        })
    }
    
    override func buildLogic() {
        
        // ViewModel.
        let storeDetailsViewModel = self.viewModel(type: StoreDetailsViewModel.self)!
        
        // Bindings.
        // StoreItem.
        storeDetailsViewModel.output.storeItem
            .unwrap()
            .subscribe(onNext:{ [weak self] (storeItem) in
                guard let self = self else { return }
                
                self.titleLabel.text = storeItem.title
                self.usernameLabel.text = String(format: "by %@", storeItem.username ?? "")
                
                self.photoImageViews.enumerated().forEach { (index, element) in
                    guard let detailImages = storeItem.detailImages else { return }
                    guard index < detailImages.count else { return }
                    
                    self.photoImageViews[index].image = detailImages[index]
                }
                
                self.priceLabel.text = String(format: "$%@", storeItem.price?.format(digit:2) ?? "999.0")
                self.nameLabel.text = storeItem.name
                
                let attributedDescription = NSMutableAttributedString(string: storeItem.description ?? "")
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = 6.0
                
                attributedDescription.addAttribute(NSAttributedString.Key.paragraphStyle,
                                                   value: paragraphStyle,
                                                   range: NSMakeRange(0, attributedDescription.length))
                
                self.descriptionLabel.attributedText = attributedDescription
            })
            .disposed(by: self.disposeBag)
        
        // PropertyView.
        storeDetailsViewModel.output.storeItem
            .bind(to: self.propertyView.storeItem)
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
