//
//  CollectionDetailsHeaderView.swift
//  Monotone
//
//  Created by Xueliang Chen on 2021/1/10.
//

import UIKit

import SnapKit
import HMSegmentedControl

import RxSwift
import RxCocoa
import RxSwiftExt

class CollectionDetailsHeaderView: BaseView {
    
    // MARK: - Public
    public let collection: BehaviorRelay<Collection?> = BehaviorRelay<Collection?>(value: nil)

    // MARK: - Controls
    private var titleLabel: UILabel!
    private var descriptionLabel: UILabel!
    private var avatarImageView: UIImageView!
    private var usernameLabel: UILabel!
    private var photoCountLabel: UILabel!
    
    // MARK: - Private
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    override func buildSubviews() {
        super.buildSubviews()
        
        //
        self.backgroundColor = ColorPalette.colorWhite
        
        // TitleLabel.
        self.titleLabel = UILabel()
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 36)
        self.titleLabel.textColor = ColorPalette.colorBlack
        self.titleLabel.text = NSLocalizedString("uns_side_menu_option_my_photos", comment: "My Photos")
        self.titleLabel.numberOfLines = 0
        
        // DescriptionLabel.
        self.descriptionLabel = UILabel()
        self.descriptionLabel.textColor = ColorPalette.colorGrayLight
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        self.descriptionLabel.text = NSLocalizedString("uns_collections_description", comment: "Explore the world through collections of beautiful HD pictures free to use under the Unsplash License.")
        self.descriptionLabel.numberOfLines = 0
        
        // AvatarImageView.
        self.avatarImageView = UIImageView()
        self.avatarImageView.contentMode = .scaleAspectFill
        self.avatarImageView.backgroundColor = ColorPalette.colorGrayLighter
        self.avatarImageView.layer.cornerRadius = 42.0
        self.avatarImageView.layer.masksToBounds = true
        
        // UsernameLabel.
        self.usernameLabel = UILabel()
        self.usernameLabel.textColor = ColorPalette.colorBlack
        self.usernameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.usernameLabel.text = "nil"
        
        // PhotoCountLabel.
        self.photoCountLabel = UILabel()
        self.photoCountLabel.textColor = ColorPalette.colorBlack
        self.photoCountLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.photoCountLabel.text = "0"
    }
    
    override func buildLogic() {
        super.buildLogic()
        
        // Bindings.
        // SegmentedControl.
        self.collection
            .unwrap()
            .subscribe(onNext: { [weak self] (collection) in
                guard let self = self else { return }
                
                //
            })
            .disposed(by: self.disposeBag)
    }
}
