//
//  HiringViewController.swift
//  Monotone
//
//  Created by Xueliang Chen on 2021/1/1.
//

import UIKit

import SnapKit
import MJRefresh

import RxSwift
import RxRelay
import RxSwiftExt

import anim
import ViewAnimator

// MARK: - HiringViewController
class HiringViewController: BaseViewController {
    
    // MARK: - Public

    
    // MARK: - Controls
    private var scrollView: UIScrollView!
    private var containerView: UIView!
    
    private var titleLabel: UILabel!
    private var sampleAImageView: UIImageView!
    private var sampleBImageView: UIImageView!
    
    private var topGradientImageView: UIImageView!
    
    private var sectionTitleLabel: UILabel!
    private var sectionContentLabel: UILabel!
    
    // MARK: - Priavte
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    override func buildSubviews() {
        
        self.view.backgroundColor = ColorPalette.colorWhite
        
        // ScrollView.
        self.scrollView = UIScrollView()
        self.view.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints { (make) in
            make.top.right.bottom.left.equalTo(self.view)
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
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 36)
        self.titleLabel.textColor = ColorPalette.colorBlack
        self.titleLabel.text = NSLocalizedString("uns_hiring_title", comment: "Help build a creative movement.")
        self.titleLabel.numberOfLines = 0
        self.containerView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.containerView).offset(10.0)
            make.left.equalTo(self.containerView).offset(18.0)
            make.right.equalTo(self.containerView).offset(-18.0)
        }
        
        // SampleAImageView.
        self.sampleAImageView = UIImageView()
        self.sampleAImageView.contentMode = .scaleAspectFill
        self.sampleAImageView.layer.masksToBounds = true
        self.sampleAImageView.image = UIImage(named: "hiring-sample-a")
        self.containerView.insertSubview(self.sampleAImageView, belowSubview: self.titleLabel)
        self.sampleAImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(40.0)
            make.left.equalTo(self.containerView)
            make.right.equalTo(self.containerView.snp.centerX)
            make.height.equalTo(322.0)
        }
        
        // SampleBImageView.
        self.sampleBImageView = UIImageView()
        self.sampleBImageView.contentMode = .scaleAspectFill
        self.sampleBImageView.layer.masksToBounds = true
        self.sampleBImageView.image = UIImage(named: "hiring-sample-b")
        self.containerView.insertSubview(self.sampleBImageView, belowSubview: self.titleLabel)
        self.sampleBImageView.snp.makeConstraints { (make) in
            make.right.equalTo(self.containerView)
            make.left.equalTo(self.containerView.snp.centerX)
            make.top.equalTo(self.sampleAImageView).offset(31.0)
            make.height.equalTo(322.0)
        }
        
        // SectionTitleLabel.
        self.sectionTitleLabel = UILabel()
        self.sectionTitleLabel.font = UIFont.boldSystemFont(ofSize: 26)
        self.sectionTitleLabel.textColor = ColorPalette.colorBlack
        self.sectionTitleLabel.text = NSLocalizedString("uns_hiring_section_title", comment: "How to Apply")
        self.sectionTitleLabel.numberOfLines = 0
        self.containerView.addSubview(self.sectionTitleLabel)
        self.sectionTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.sampleAImageView.snp.bottom).offset(65.0)
            make.left.equalTo(self.containerView).offset(18.0)
            make.right.equalTo(self.containerView).offset(-120.0)
        }
        
        // SectionContentLabel.
        let attributedContent = NSMutableAttributedString(string: NSLocalizedString("uns_hiring_section_content", comment: "If you want to work with us, all we want to see is a message from you. Please don’t send a resume. Instead, tell us who you are. Show us relevant things you’ve done that you’re excited about."))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6.0
        
        attributedContent.addAttribute(NSAttributedString.Key.paragraphStyle,
                                       value: paragraphStyle,
                                       range: NSMakeRange(0, attributedContent.length))
        
        self.sectionContentLabel = UILabel()
        self.sectionContentLabel.font = UIFont.systemFont(ofSize: 16)
        self.sectionContentLabel.textColor = ColorPalette.colorGrayLight
        self.sectionContentLabel.numberOfLines = 0
        self.sectionContentLabel.attributedText = attributedContent
        self.containerView.addSubview(self.sectionContentLabel)
        self.sectionContentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.sectionTitleLabel.snp.bottom).offset(12.0)
            make.left.equalTo(self.containerView).offset(18.0)
            make.right.equalTo(self.containerView).offset(-18.0)
            make.bottom.equalTo(self.containerView).offset(-20.0)
        }
        
        // TopGradientView.
        self.topGradientImageView = UIImageView()
        self.topGradientImageView.image = UIImage(named: "list-top-gradient")
        self.containerView.insertSubview(self.topGradientImageView, belowSubview: self.titleLabel)
        self.topGradientImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.sampleAImageView)
            make.right.left.equalTo(self.view)
            make.height.equalTo(92.0)
        }
    }
    
    override func buildLogic() {
        
        // ViewModel.
        //
        
        // Bindings.
        //
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
