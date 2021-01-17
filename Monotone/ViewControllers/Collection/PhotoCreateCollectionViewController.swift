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
import RxSwiftExt

import Kingfisher
import BEMCheckBox

// MARK: - PhotoCreateCollectionViewController
class PhotoCreateCollectionViewController: BaseViewController {
    
    // MARK: - Controls
    private var pageTitleView: PageTitleView!
    
    private var titleLabel: UILabel!
    private var titleTextField: MTTextField!
    private var descriptionLabel: UILabel!
    private var descriptionTextView: UITextView!
    
    private var privateCheckBox: BEMCheckBox!
    private var privateLabel: UILabel!
    
    private var submitBtn: UIButton!
    
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
        
        // PageTitleView.
        self.pageTitleView = PageTitleView()
        self.view.addSubview(self.pageTitleView)
        self.pageTitleView.snp.makeConstraints { (make) in
            make.left.equalTo(15.0)
            make.right.equalTo(-15.0)
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(40.0)
            make.height.equalTo(50.0)
        }
        
        // TitleTextField
        self.titleTextField = MTTextField()
        self.titleTextField.iconLeftMargin = 0
        self.titleTextField.layer.cornerRadius = 6.0
        self.titleTextField.layer.masksToBounds = true
        self.titleTextField.layer.borderWidth = 1.0
        self.titleTextField.layer.borderColor = ColorPalette.colorGrayHeavy.cgColor
        self.view.addSubview(self.titleTextField)
        self.titleTextField.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(16.0)
            make.right.equalTo(self.view).offset(-16.0)
            make.top.equalTo(self.pageTitleView.snp.bottom).offset(53.0)
            make.height.equalTo(44.0)
        }
        
        // TitleLabel.
        self.titleLabel = UILabel()
        self.titleLabel.font = UIFont.systemFont(ofSize: 16)
        self.titleLabel.textColor = ColorPalette.colorGrayHeavy
        self.titleLabel.text = NSLocalizedString("uns_create_collection_form_title", comment: "Name")
        self.view.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleTextField)
            make.bottom.equalTo(self.titleTextField.snp.top).offset(-11.0)
        }
        
        // DescriptionTextView
        self.descriptionTextView = UITextView()
        self.descriptionTextView.layer.cornerRadius = 6.0
        self.descriptionTextView.layer.masksToBounds = true
        self.descriptionTextView.layer.borderWidth = 1.0
        self.descriptionTextView.layer.borderColor = ColorPalette.colorGrayHeavy.cgColor
        self.view.addSubview(self.descriptionTextView)
        self.descriptionTextView.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleTextField.snp.bottom).offset(61.0)
            make.left.equalTo(self.view).offset(18.0)
            make.right.equalTo(self.view).offset(-18.0)
            make.height.equalTo(84.0)
        }
        
        // DescriptionLabel.
        self.descriptionLabel = UILabel()
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        self.descriptionLabel.textColor = ColorPalette.colorGrayHeavy
        self.descriptionLabel.text = NSLocalizedString("uns_create_collection_form_description", comment: "Description (Optional)")
        self.view.addSubview(self.descriptionLabel)
        self.descriptionLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.descriptionTextView)
            make.bottom.equalTo(self.descriptionTextView.snp.top).offset(-11.0)
        }
        
        // PrivateCheckBox
        self.privateCheckBox = BEMCheckBox()
        self.privateCheckBox.boxType = .square
        self.privateCheckBox.onAnimationType = .bounce
        self.privateCheckBox.offAnimationType = .bounce
        self.privateCheckBox.onTintColor = ColorPalette.colorGrayHeavy
        self.privateCheckBox.onFillColor = ColorPalette.colorGrayHeavy
        self.privateCheckBox.onCheckColor = UIColor.white
        self.privateCheckBox.delegate = self
        self.view.addSubview(self.privateCheckBox)
        self.privateCheckBox.snp.makeConstraints { (make) in
            make.width.height.equalTo(12.0)
            make.left.equalTo(self.descriptionTextView)
            make.top.equalTo(self.descriptionTextView.snp.bottom).offset(20.0)
        }
        
        // PrivateLabel.
        self.privateLabel = UILabel()
        self.privateLabel.font = UIFont.systemFont(ofSize: 12)
        self.privateLabel.textColor = ColorPalette.colorGrayHeavy
        self.privateLabel.text = NSLocalizedString("uns_create_collection_form_option_private", comment: "Make collection private")
        self.view.addSubview(self.privateLabel)
        self.privateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.privateCheckBox.snp.right).offset(9.0)
            make.centerY.equalTo(self.privateCheckBox)
        }
        
        // SubmitBtn.
        self.submitBtn = UIButton()
        self.submitBtn.backgroundColor = ColorPalette.colorBlack
        self.submitBtn.contentEdgeInsets = UIEdgeInsets(top: 11.0, left: 20.0, bottom: 11.0, right: 20.0)
        self.submitBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.submitBtn.setTitleColor(ColorPalette.colorWhite, for: .normal)
        self.submitBtn.setTitle(NSLocalizedString("uns_create_collection_form_button_submit", comment: "Create Collection"), for: .normal)
        self.submitBtn.layer.cornerRadius = 6.0
        self.submitBtn.layer.masksToBounds = true
        self.view.addSubview(self.submitBtn)
        self.submitBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.descriptionTextView.snp.bottom).offset(70.0)
            make.centerX.equalTo(self.view)
        }
    }
    
    override func buildLogic() {
                
        // ViewModel.
        let photoCreateCollectionViewModel = self.viewModel(type: PhotoCreateCollectionViewModel.self)!
        
        // Bindings.
        // PageTitleView.
        self.pageTitleView.title.accept(NSLocalizedString("uns_create_collection_title", comment: "Create new collection"))
        
        // TitleTextField.
        self.titleTextField.rx.text.orEmpty
            .bind(to: photoCreateCollectionViewModel.input.title)
            .disposed(by: self.disposeBag)
        
        // DescriptionTextView.
        self.descriptionTextView.rx.text.orEmpty
            .bind(to: photoCreateCollectionViewModel.input.description)
            .disposed(by: self.disposeBag)
        
        // SubmitBtn.
        self.submitBtn.rx.tap
            .subscribe { (_) in
                photoCreateCollectionViewModel.input.submitAction?.execute()
            }
            .disposed(by: self.disposeBag)
        
        // Pop.
        photoCreateCollectionViewModel.output.collection
            .unwrap()
            .subscribe { [weak self] (_) in
                guard let self = self else { return }
                
                self.pop()
            } onError: { (error) in
                // TODO: handle error
                
            }
            .disposed(by: self.disposeBag)

    }
}

// MARK: - BEMCheckBoxDelegate
extension PhotoCreateCollectionViewController: BEMCheckBoxDelegate{
    func didTap(_ checkBox: BEMCheckBox) {
        
        // ViewModel.
        let photoCreateCollectionViewModel = self.viewModel(type: PhotoCreateCollectionViewModel.self)!
        
        photoCreateCollectionViewModel.input.isPrivate.accept(checkBox.isSelected)
    }
}
