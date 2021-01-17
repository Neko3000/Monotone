//
//  HMSegmentedControl+Selection.swift
//  Monotone
//
//  Created by Xueliang Chen on 2021/1/17.
//

import Foundation

import HMSegmentedControl

extension HMSegmentedControl {

    public func equalToSelectedSegmentIndex(index: Int) -> Bool{
        return NSDecimalNumber(value: index) ==  NSDecimalNumber(value: self.selectedSegmentIndex)
    }
    
    public func setSelectedSegmentIndex(index: Int, animated: Bool){
        if(index < 0 || self.sectionTitles == nil || index > self.sectionTitles!.count){
            self.setSelectedSegmentIndex(HMSegmentedControlNoSegment, animated: animated)
        }
        else{
            self.setSelectedSegmentIndex(UInt(index), animated: animated)
        }
    }
}
