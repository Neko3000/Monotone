//
//  UserStatisticsView.swift
//  Monotone
//
//  Created by Xueliang Chen on 2021/1/31.
//

import UIKit

import RxSwift
import RxRelay
import RxSwiftExt

class UserStatisticsView: BaseView {
    
    // MARK: - Public
    public var statistics: BehaviorRelay<Statistics?> = BehaviorRelay<Statistics?>(value: nil)
    
    // MARK: - Controls
    private var viewCountContainterView: UIView!
    private var viewCountTitleLabel: UILabel!
    private var viewCountLabel: UILabel!
    private var viewCountCompareLabel: UILabel!
    private var viewSinceLastMonthLabel: UILabel!
    
    private var likeCountContainterView: UIView!
    private var likeCountTitleLabel: UILabel!
    private var likeCountLabel: UILabel!
    private var likeCountCompareLabel: UILabel!
    private var likeSinceLastMonthLabel: UILabel!
    
    private var downloadCountContainterView: UIView!
    private var downloadCountTitleLabel: UILabel!
    private var downloadCountLabel: UILabel!
    private var downloadCountCompareLabel: UILabel!
    private var downloadSinceLastMonthLabel: UILabel!
    
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
    override func buildSubviews() {
        super.buildSubviews()
        
        // ViewCountContainerView.
        self.viewCountContainterView = UIView()
        self.addSubview(self.viewCountContainterView)
        self.viewCountContainterView.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.height.equalTo(self).multipliedBy(1.0/3)
            make.left.right.equalTo(self)
        }
        
        // ViewCountTitleLabel.
        self.viewCountTitleLabel = UILabel()
        self.viewCountTitleLabel.text = "Views"
        self.viewCountTitleLabel.textColor = ColorPalette.colorBlack
        self.viewCountTitleLabel.font = UIFont.systemFont(ofSize: 12)
        self.viewCountContainterView.addSubview(self.viewCountTitleLabel)
        self.viewCountLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.viewCountContainterView)
            make.left.equalTo(self.viewCountContainterView).offset(20.0)
            make.right.equalTo(self.viewCountContainterView).offset(-20.0)
        }
        
        // ViewCountLabel.
        self.viewCountLabel = UILabel()
        self.viewCountLabel.text = "0"
        self.viewCountLabel.textColor = ColorPalette.colorBlack
        self.viewCountLabel.font = UIFont.boldSystemFont(ofSize: 24)
        self.viewCountContainterView.addSubview(self.viewCountLabel)
        self.viewCountLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.viewCountTitleLabel.snp.bottom).offset(7.0)
            make.left.equalTo(self.viewCountContainterView).offset(20.0)
            make.right.equalTo(self.viewCountContainterView).offset(-20.0)
        }
        
        // ViewCountCompareLabel.
        self.viewCountCompareLabel = UILabel()
        self.viewCountCompareLabel.text = "+0"
        self.viewCountCompareLabel.textColor = ColorPalette.colorBlack
        self.viewCountCompareLabel.font = UIFont.systemFont(ofSize: 10)
        self.viewCountContainterView.addSubview(self.viewCountCompareLabel)
        self.viewCountCompareLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.viewCountLabel.snp.bottom).offset(4.0)
            make.left.equalTo(self.viewCountContainterView).offset(20.0)
        }
        
        // ViewSinceLastMonthLabel.
        self.viewSinceLastMonthLabel = UILabel()
        self.viewSinceLastMonthLabel.text = NSLocalizedString("uns_info_since_to_last_month", comment: "since last month")
        self.viewSinceLastMonthLabel.textColor = ColorPalette.colorGrayLight
        self.viewSinceLastMonthLabel.font = UIFont.systemFont(ofSize: 8)
        self.viewSinceLastMonthLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        self.viewCountContainterView.addSubview(self.viewSinceLastMonthLabel)
        self.viewSinceLastMonthLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.viewCountCompareLabel)
            make.left.equalTo(self.viewCountCompareLabel.snp.right).offset(5.0)
            make.right.equalTo(self.viewCountContainterView).offset(-20.0)
        }
        
        // LikeCountContainterView.
        self.likeCountContainterView = UIView()
        self.addSubview(self.likeCountContainterView)
        self.likeCountContainterView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.bottom).multipliedBy(1.0/3)
            make.height.equalTo(self).multipliedBy(1.0/3)
            make.left.right.equalTo(self)
        }
        
        // LikeCountTitleLabel.
        self.likeCountTitleLabel = UILabel()
        self.likeCountTitleLabel.text = "Likes"
        self.likeCountTitleLabel.textColor = ColorPalette.colorBlack
        self.likeCountTitleLabel.font = UIFont.systemFont(ofSize: 12)
        self.likeCountContainterView.addSubview(self.likeCountTitleLabel)
        self.likeCountTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.likeCountContainterView)
            make.left.equalTo(self.likeCountContainterView).offset(20.0)
            make.right.equalTo(self.likeCountContainterView).offset(-20.0)
        }
        
        // LikeCountLabel.
        self.likeCountLabel = UILabel()
        self.likeCountLabel.text = "0"
        self.likeCountLabel.textColor = ColorPalette.colorBlack
        self.likeCountLabel.font = UIFont.boldSystemFont(ofSize: 24)
        self.likeCountContainterView.addSubview(self.likeCountLabel)
        self.likeCountLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.likeCountTitleLabel.snp.bottom).offset(7.0)
            make.left.equalTo(self.likeCountContainterView).offset(20.0)
            make.right.equalTo(self.likeCountContainterView).offset(-20.0)
        }
        
        // LikeCountCompareLabel.
        self.likeCountCompareLabel = UILabel()
        self.likeCountCompareLabel.text = "+0"
        self.likeCountCompareLabel.textColor = ColorPalette.colorBlack
        self.likeCountCompareLabel.font = UIFont.systemFont(ofSize: 10)
        self.likeCountContainterView.addSubview(self.likeCountCompareLabel)
        self.likeCountCompareLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.likeCountLabel.snp.bottom).offset(4.0)
            make.left.equalTo(self.likeCountContainterView).offset(20.0)
        }
        
        // LikeSinceLastMonthLabel.
        self.likeSinceLastMonthLabel = UILabel()
        self.likeSinceLastMonthLabel.text = NSLocalizedString("uns_info_since_to_last_month", comment: "since last month")
        self.likeSinceLastMonthLabel.textColor = ColorPalette.colorGrayLight
        self.likeSinceLastMonthLabel.font = UIFont.systemFont(ofSize: 8)
        self.likeSinceLastMonthLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        self.likeCountContainterView.addSubview(self.likeSinceLastMonthLabel)
        self.likeSinceLastMonthLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.likeCountCompareLabel)
            make.left.equalTo(self.likeCountCompareLabel.snp.right).offset(5.0)
            make.right.equalTo(self.likeCountContainterView).offset(-20.0)
        }
        
        // DownloadCountContainerView.
        self.downloadCountContainterView = UIView()
        self.addSubview(self.downloadCountContainterView)
        self.downloadCountContainterView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.bottom).multipliedBy(2.0/3)
            make.height.equalTo(self).multipliedBy(1.0/3)
            make.left.right.equalTo(self)
        }
        
        // DownloadCountTitleLabel.
        self.downloadCountTitleLabel = UILabel()
        self.downloadCountTitleLabel.text = "Downloads"
        self.downloadCountTitleLabel.textColor = ColorPalette.colorBlack
        self.downloadCountTitleLabel.font = UIFont.systemFont(ofSize: 12)
        self.downloadCountContainterView.addSubview(self.downloadCountTitleLabel)
        self.downloadCountTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.downloadCountContainterView)
            make.left.equalTo(self.downloadCountContainterView).offset(20.0)
            make.right.equalTo(self.downloadCountContainterView).offset(-20.0)
        }
        
        // DownloadCountLabel.
        self.downloadCountLabel = UILabel()
        self.downloadCountLabel.text = "0"
        self.downloadCountLabel.textColor = ColorPalette.colorBlack
        self.downloadCountLabel.font = UIFont.boldSystemFont(ofSize: 24)
        self.downloadCountContainterView.addSubview(self.downloadCountLabel)
        self.downloadCountLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.downloadCountTitleLabel.snp.bottom).offset(7.0)
            make.left.equalTo(self.downloadCountContainterView).offset(20.0)
            make.right.equalTo(self.downloadCountContainterView).offset(-20.0)
        }
        
        // DownloadCountCompareLabel.
        self.downloadCountCompareLabel = UILabel()
        self.downloadCountCompareLabel.text = "+0"
        self.downloadCountCompareLabel.textColor = ColorPalette.colorBlack
        self.downloadCountCompareLabel.font = UIFont.systemFont(ofSize: 10)
        self.downloadCountContainterView.addSubview(self.downloadCountCompareLabel)
        self.downloadCountCompareLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.downloadCountLabel.snp.bottom).offset(4.0)
            make.left.equalTo(self.downloadCountContainterView).offset(20.0)
        }
        
        // DownloadSinceLastMonthLabel.
        self.downloadSinceLastMonthLabel = UILabel()
        self.downloadSinceLastMonthLabel.text = NSLocalizedString("uns_info_since_to_last_month", comment: "since last month")
        self.downloadSinceLastMonthLabel.textColor = ColorPalette.colorGrayLight
        self.downloadSinceLastMonthLabel.font = UIFont.systemFont(ofSize: 8)
        self.downloadSinceLastMonthLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        self.downloadCountContainterView.addSubview(self.downloadSinceLastMonthLabel)
        self.downloadSinceLastMonthLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.downloadCountCompareLabel)
            make.left.equalTo(self.downloadCountContainterView).offset(20.0)
            make.right.equalTo(self.downloadCountContainterView).offset(-20.0)
        }
    }
    
    override func buildLogic() {
        super.buildLogic()
        
        // Bindings
        self.statistics
            .unwrap()
            .subscribe(onNext: { [weak self] (statistics) in
                guard let self = self else { return }
                
                let numberFormatter = NumberFormatter()
                numberFormatter.usesGroupingSeparator = true
                numberFormatter.groupingSeparator = ","
                numberFormatter.groupingSize = 3

                if let viewCountTotal = statistics.views?.total{
                    self.viewCountLabel.text = numberFormatter.string(from: NSNumber(value: viewCountTotal))
                }
                if let likeCountTotal = statistics.likes?.total{
                    self.likeCountLabel.text = numberFormatter.string(from: NSNumber(value: likeCountTotal))
                }
                if let downloadCountTotal = statistics.downloads?.total{
                    self.downloadCountLabel.text = numberFormatter.string(from: NSNumber(value: downloadCountTotal))
                }
                
                numberFormatter.positivePrefix = "+"
                numberFormatter.negativePrefix = "-"
                
                if let viewCountChange = statistics.views?.historical?.change{
                    self.viewCountCompareLabel.text = numberFormatter.string(from: NSNumber(value: viewCountChange))
                }
                if let likeCountChange = statistics.likes?.historical?.change{
                    self.likeCountCompareLabel.text = numberFormatter.string(from: NSNumber(value: likeCountChange))
                }
                if let downloadCountChange = statistics.downloads?.historical?.change{
                    self.downloadCountCompareLabel.text = numberFormatter.string(from: NSNumber(value: downloadCountChange))
                }
        })
            .disposed(by: self.disposeBag)

    }
}
