//
//  CollectionsTableViewCell.swift
//  Monotone
//
//  Created by Xueliang Chen on 2021/1/18.
//

import Foundation

import RxSwift
import RxRelay

class CollectionsTableViewCell: UITableViewCell{
    
    // MARK: - Public
    var collection: BehaviorRelay<Collection?> = BehaviorRelay<Collection?>(value: nil)
    
    public var alignToRight: Bool = false{
        didSet{
            self.resetLayout()
        }
    }
    
    // MARK: - Controls
    private var photoContainerView: UIView!
    private var photoAImageView: UIImageView!
    private var photoBImageView: UIImageView!
    private var photoCImageView: UIImageView!
        
    private var titleLabel: UILabel!
    private var descriptionLabel: UILabel!
    
    private var arrowImageView: UIImageView!

    // MARK: - Private
    private let disposeBag: DisposeBag = DisposeBag()
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.buildSubviews()
        self.buildLogic()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildSubviews() {
        
        self.selectionStyle = .none
        
        // PhotoContainerView.
        self.photoContainerView = UIView()
        self.contentView.addSubview(self.photoContainerView)
        self.photoContainerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView).offset(33.0)
            make.right.equalTo(self.contentView).offset(-42.0)
            make.left.equalTo(self.contentView).offset(18.0)
        }

        // PhotoAImageView.
        self.photoAImageView = UIImageView()
        self.photoAImageView.contentMode = .scaleAspectFill
        self.photoAImageView.backgroundColor = ColorPalette.colorGrayLighter
        self.photoAImageView.layer.masksToBounds = true
        self.photoAImageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        self.photoAImageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        self.photoContainerView.addSubview(self.photoAImageView)
        self.photoAImageView.snp.makeConstraints { (make) in
            make.top.left.equalTo(self.photoContainerView)
            make.bottom.equalTo(self.photoContainerView.snp.bottom).multipliedBy(1.0/3).offset(-2.0)
            make.right.equalTo(self.photoContainerView.snp.right).multipliedBy(1.0/2).offset(-2.0)
        }

        // PhotoBImageView.
        self.photoBImageView = UIImageView()
        self.photoBImageView.contentMode = .scaleAspectFill
        self.photoBImageView.backgroundColor = ColorPalette.colorGrayLighter
        self.photoBImageView.layer.masksToBounds = true
        self.photoBImageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        self.photoBImageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        self.photoContainerView.addSubview(self.photoBImageView)
        self.photoBImageView.snp.makeConstraints { (make) in
            make.left.bottom.equalTo(self.photoContainerView)
            make.top.equalTo(self.photoContainerView.snp.bottom).multipliedBy(1.0/3).offset(2.0)
            make.right.equalTo(self.photoContainerView.snp.right).multipliedBy(1.0/2).offset(-2.0)
        }

        // PhotoCImageView.
        self.photoCImageView = UIImageView()
        self.photoCImageView.contentMode = .scaleAspectFill
        self.photoCImageView.backgroundColor = ColorPalette.colorGrayLighter
        self.photoCImageView.layer.masksToBounds = true
        self.photoCImageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        self.photoCImageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        self.photoContainerView.addSubview(self.photoCImageView)
        self.photoCImageView.snp.makeConstraints { (make) in
            make.top.right.bottom.equalTo(self.photoContainerView)
            make.left.equalTo(self.photoContainerView.snp.right).multipliedBy(1.0/2).offset(2.0)
        }
        
        // TitleLabel.
        self.titleLabel = UILabel()
        self.titleLabel.textColor = ColorPalette.colorBlack
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 12)
        self.titleLabel.text = "nil"
        self.titleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        self.titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.photoContainerView.snp.bottom).offset(7.0)
            make.left.equalTo(self.photoContainerView)
        }
        
        // DescriptionLabel.
        self.descriptionLabel = UILabel()
        self.descriptionLabel.textColor = ColorPalette.colorGrayLight
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 12)
        self.descriptionLabel.text = "0 photos · Curated by nil"
        self.descriptionLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        self.descriptionLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        self.contentView.addSubview(self.descriptionLabel)
        self.descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(7.0)
            make.left.equalTo(self.photoContainerView)
            make.bottom.equalTo(self.contentView)
        }
        
        // ArrowImageView.
        self.arrowImageView = UIImageView()
        self.arrowImageView.image = UIImage(named: "collections-btn-right-arrow")
        self.contentView.addSubview(self.arrowImageView)
        self.arrowImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.photoContainerView.snp.right)
            make.centerY.equalTo(self.photoContainerView.snp.bottom)
            make.width.height.equalTo(50.0)
        }
    }
    
    private func buildLogic() {
            
        // Bindings.
        // Collection.
        self.collection
            .unwrap()
            .subscribe(onNext:{ [weak self] (collection) in
                guard let self = self else { return }
                                
                let editor = collection.sponsorship?.sponsor ?? collection.user

                self.titleLabel.text = collection.title
                self.descriptionLabel.text = String(format: NSLocalizedString("uns_side_menu_collection_description",
                                                                              comment: "%d Photos · Curated by %@"),
                                                    collection.totalPhotos ?? 0,
                                                    editor?.username ?? "")
                
                collection.previewPhotos?
                    .prefix(self.photoContainerView.subviews.count)
                    .enumerated()
                    .forEach({ (index, element) in
                        let imageView = self.photoContainerView.subviews[index] as! UIImageView
                        
                        imageView.setPhoto(photo: element, size: .small)
                    })
                
                
            })
            .disposed(by: self.disposeBag)
    }
    
    private func resetLayout(){
        
        if(self.alignToRight){
            
            self.photoContainerView.snp.remakeConstraints { (make) in
                make.top.equalTo(self.contentView).offset(33.0)
                make.right.equalTo(self.contentView).offset(-18.0)
                make.left.equalTo(self.contentView).offset(42.0)
            }
            
            self.photoAImageView.snp.remakeConstraints { (make) in
                make.top.left.equalTo(self.photoContainerView)
                make.bottom.equalTo(self.photoContainerView.snp.bottom).multipliedBy(1.0/3).offset(-2.0)
                make.right.equalTo(self.photoContainerView.snp.right).multipliedBy(1.0/2).offset(-2.0)
            }

            self.photoBImageView.snp.remakeConstraints { (make) in
                make.left.bottom.equalTo(self.photoContainerView)
                make.top.equalTo(self.photoContainerView.snp.bottom).multipliedBy(1.0/3).offset(2.0)
                make.right.equalTo(self.photoContainerView.snp.right).multipliedBy(1.0/2).offset(-2.0)
            }

            self.photoCImageView.snp.remakeConstraints { (make) in
                make.top.right.bottom.equalTo(self.photoContainerView)
                make.left.equalTo(self.photoContainerView.snp.right).multipliedBy(1.0/2).offset(2.0)
            }
            
            self.titleLabel.snp.remakeConstraints { (make) in
                make.top.equalTo(self.photoContainerView.snp.bottom).offset(7.0)
                make.right.equalTo(self.photoContainerView)
            }
            
            self.descriptionLabel.snp.remakeConstraints { (make) in
                make.top.equalTo(self.titleLabel.snp.bottom).offset(7.0)
                make.right.equalTo(self.photoContainerView)
                make.bottom.equalTo(self.contentView)
            }
            
            self.arrowImageView.image = UIImage(named: "collections-btn-left-arrow")
            self.arrowImageView.snp.remakeConstraints { (make) in
                make.centerX.equalTo(self.photoContainerView.snp.left)
                make.centerY.equalTo(self.photoContainerView.snp.bottom)
                make.width.height.equalTo(50.0)
            }
            
        }
        else{

            self.photoContainerView.snp.remakeConstraints { (make) in
                make.top.equalTo(self.contentView).offset(33.0)
                make.right.equalTo(self.contentView).offset(-42.0)
                make.left.equalTo(self.contentView).offset(18.0)
            }
            
            self.photoAImageView.snp.remakeConstraints { (make) in
                make.top.left.equalTo(self.photoContainerView)
                make.bottom.equalTo(self.photoContainerView.snp.bottom).multipliedBy(1.0/2).offset(-2.0)
                make.right.equalTo(self.photoContainerView.snp.right).multipliedBy(2.0/3).offset(-2.0)
            }

            self.photoBImageView.snp.remakeConstraints { (make) in
                make.left.bottom.equalTo(self.photoContainerView)
                make.top.equalTo(self.photoContainerView.snp.bottom).multipliedBy(1.0/2).offset(2.0)
                make.right.equalTo(self.photoContainerView.snp.right).multipliedBy(2.0/3).offset(-2.0)
            }

            self.photoCImageView.snp.remakeConstraints { (make) in
                make.top.right.bottom.equalTo(self.photoContainerView)
                make.left.equalTo(self.photoContainerView.snp.right).multipliedBy(2.0/3).offset(2.0)
            }
            
            self.titleLabel.snp.remakeConstraints { (make) in
                make.top.equalTo(self.photoContainerView.snp.bottom).offset(7.0)
                make.left.equalTo(self.photoContainerView)
            }
            
            self.descriptionLabel.snp.remakeConstraints { (make) in
                make.top.equalTo(self.titleLabel.snp.bottom).offset(7.0)
                make.left.equalTo(self.photoContainerView)
                make.bottom.equalTo(self.contentView)
            }
            
            self.arrowImageView.image = UIImage(named: "collections-btn-right-arrow")
            self.arrowImageView.snp.remakeConstraints { (make) in
                make.centerX.equalTo(self.photoContainerView.snp.right)
                make.centerY.equalTo(self.photoContainerView.snp.bottom)
                make.width.height.equalTo(50.0)
            }
            
        }
        
        self.layoutIfNeeded()
    }
}
