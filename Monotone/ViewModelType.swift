//
//  ViewModelType.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/7.
//

import Foundation
import RxSwift

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input:Input)->Output
}

class SearchPhotosViewModelType: ViewModelType{
    
    /// MARK: Input
    struct Input {
        let query: BehaviorSubject<String>
        let needLoadMore: BehaviorSubject<Bool>
    }
    let input:Input
    
    /// MARK: Output
    struct Output {
        let query: String
        let isLoadingMore: BehaviorSubject<Bool>
    }
    
    /// MARK:
    let currentPage:Int = 1
    
    func transform(input:Input) -> Output {
        return Output(query: "over")
    }
}
