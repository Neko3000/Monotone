//
//  GradientView.swift
//  Monotone
//
//  Created by Xueliang Chen on 2021/1/1.
//

import UIKit

class GradientView: BaseView {
    
    public var lightColors: [CGColor]?{
        didSet{
            self.updateGradient()
        }
    }
    
    public var darkColors: [CGColor]?{
        didSet{
            self.updateGradient()
        }
    }
    
    public var locations: [NSNumber]?{
        didSet{
            self.updateGradient()
        }
    }
    
    public var startPoint: CGPoint?{
        didSet{
            self.updateGradient()
        }
    }
    
    public var endPoint: CGPoint?{
        didSet{
            self.updateGradient()
        }
    }
    
    private var gradientLayer: CAGradientLayer?


    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    private func updateGradient(){
        
        let colorsByUserInterface = self.traitCollection.userInterfaceStyle == .dark ? darkColors : lightColors
        
        guard let colors = colorsByUserInterface,
              let startPoint = self.startPoint,
              let endPoint = self.endPoint
        else{
            return
        }
        
        
        // Remove.
        self.gradientLayer?.removeFromSuperlayer()
        
        // Create.
        self.gradientLayer = CAGradientLayer()

        self.gradientLayer!.frame = self.bounds
        self.gradientLayer!.colors = colors
        
        self.gradientLayer!.startPoint = startPoint
        self.gradientLayer!.endPoint = endPoint
        self.gradientLayer!.locations = locations
        self.layer.addSublayer(self.gradientLayer!)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.updateGradient()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        self.updateGradient()
    }
}
