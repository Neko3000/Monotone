//
//  PhotoCreateCollectionViewController.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/4.
//

import UIKit

import RxSwift
import RxRelay
import RxCocoa
import Kingfisher

import BEMCheckBox

// MARK: - PhotoCreateCollectionViewController
class PhotoCreateCollectionViewController: BaseViewController {
    
    // MARK: - Controls
    private var pageTitleView: PageTitleView!
    
    private var nameLabel: UILabel!
    private var nameTextField: MTTextField!
    private var descriptionLabel: UILabel!
    private var descriptionTextView: UITextView!
    
    private var privateCheckBox: BEMCheckBox!
    private var privateLabel: UILabel!
    
    private var confirmBtn: UIButton!
    
    // MARK: - Private
    private let disposeBag: DisposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Life Cycle
    override func buildSubviews() {
        self.view.backgroundColor = ColorPalette.colorWhite
        
        // pageTitleView.
        self.pageTitleView = PageTitleView()
        self.view.addSubview(self.pageTitleView)
        self.pageTitleView.snp.makeConstraints { (make) in
            make.left.equalTo(15.0)
            make.right.equalTo(-15.0)
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(40.0)
            make.height.equalTo(50.0)
        }
        
        // nameTextField
        self.nameTextField = MTTextField()
        self.nameTextField.iconLeftMargin = 0
        self.nameTextField.layer.cornerRadius = 6.0
        self.nameTextField.layer.masksToBounds = true
        self.nameTextField.layer.borderWidth = 1.0
        self.nameTextField.layer.borderColor = ColorPalette.colorGrayHeavy.cgColor
        self.view.addSubview(self.nameTextField)
        self.nameTextField.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(16.0)
            make.right.equalTo(self.view).offset(-16.0)
            make.top.equalTo(self.pageTitleView.snp.bottom).offset(53.0)
            make.height.equalTo(44.0)
        }
        
        // nameLabel.
        self.nameLabel = UILabel()
        self.nameLabel.font = UIFont.systemFont(ofSize: 16)
        self.nameLabel.textColor = ColorPalette.colorGrayHeavy
        self.nameLabel.text = "Name"
        self.view.addSubview(self.nameLabel)
        self.nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.nameTextField)
            make.bottom.equalTo(self.nameTextField.snp.top).offset(-11.0)
        }
        
        // descriptionTextView
        self.descriptionTextView = UITextView()
        self.descriptionTextView.layer.cornerRadius = 6.0
        self.descriptionTextView.layer.masksToBounds = true
        self.descriptionTextView.layer.borderWidth = 1.0
        self.descriptionTextView.layer.borderColor = ColorPalette.colorGrayHeavy.cgColor
        self.view.addSubview(self.descriptionTextView)
        self.descriptionTextView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(16.0)
            make.right.equalTo(self.view).offset(-16.0)
            make.top.equalTo(self.nameTextField.snp.bottom).offset(61.0)
            make.height.equalTo(84.0)
        }
        
        // descriptionLabel.
        self.descriptionLabel = UILabel()
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        self.descriptionLabel.textColor = ColorPalette.colorGrayHeavy
        self.descriptionLabel.text = "Description (Optional)"
        self.view.addSubview(self.descriptionLabel)
        self.descriptionLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.descriptionTextView)
            make.bottom.equalTo(self.descriptionTextView.snp.top).offset(-11.0)
        }
        
        // privateCheckBox
        self.privateCheckBox = BEMCheckBox()
        self.privateCheckBox.boxType = .square
        self.privateCheckBox.onAnimationType = .bounce
        self.privateCheckBox.offAnimationType = .bounce
        self.privateCheckBox.onTintColor = ColorPalette.colorGrayHeavy
        self.privateCheckBox.onFillColor = ColorPalette.colorGrayHeavy
        self.privateCheckBox.onCheckColor = UIColor.white
        self.view.addSubview(self.privateCheckBox)
        self.privateCheckBox.snp.makeConstraints { (make) in
            make.width.height.equalTo(12.0)
            make.left.equalTo(self.descriptionTextView)
            make.top.equalTo(self.descriptionTextView.snp.bottom).offset(20.0)
        }
        
        // privateLabel.
        self.privateLabel = UILabel()
        self.privateLabel.font = UIFont.systemFont(ofSize: 12)
        self.privateLabel.textColor = ColorPalette.colorGrayHeavy
        self.privateLabel.text = "Make collection private"
        self.view.addSubview(self.privateLabel)
        self.privateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.privateCheckBox.snp.right).offset(9.0)
            make.centerY.equalTo(self.privateCheckBox)
        }
        
        // confirmBtn.
        self.confirmBtn = UIButton()
        self.confirmBtn.backgroundColor = ColorPalette.colorBlack
        self.confirmBtn.contentEdgeInsets = UIEdgeInsets(top: 11.0, left: 20.0, bottom: 11.0, right: 20.0)
        self.confirmBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.confirmBtn.setTitleColor(ColorPalette.colorWhite, for: .normal)
        self.confirmBtn.setTitle("Create Collection", for: .normal)
        self.confirmBtn.layer.cornerRadius = 6.0
        self.confirmBtn.layer.masksToBounds = true
        self.view.addSubview(self.confirmBtn)
        self.confirmBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self.view).offset(-16.0)
            make.bottom.equalTo(self.view).offset(-23.0)
        }
    }
    
    override func buildLogic() {
                
        // ViewModel.
        let photoCreateCollectionViewModel = self.viewModel(type: PhotoCreateCollectionViewModel.self)!
        
        // Bindings.
        self.pageTitleView.title.accept(NSLocalizedString("unsplash_create_collection_title", comment: "Create new collection"))
        
    }
}
