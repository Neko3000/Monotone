//
//  ViewModelProtocol.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/7.
//

import Foundation

import RxSwift
import Action

protocol ViewModelProtocol {
    associatedtype Input
    associatedtype Output
    
    var input:Input { get }
    var output:Output { get }
    func transform(input:Input)->Output
}

class SearchPhotosViewModel: ViewModelProtocol{
    
    /// MARK: Input
    struct Input {
        var query: BehaviorSubject<String>?
        var loadMoreAction: Action<Void, Void>?
        var reloadAction: Action<Void, Void>?
    }
    public let input:Input = Input()
    
    /// MARK: Output
    struct Output {
        var photos: BehaviorSubject<[NSObject]>?
        var loading: BehaviorSubject<Bool>?
    }
    public let output: Output = Output()
    
    /// MARK: Private
    let currentPage:Int = 1
    
    init() {
//        self.input.query = BehaviorSubject<String>(value: "")
//        self.input.loadMoreAction = Action<Void, Void>(workFactory: { [weak self] in
//
//        })
    }
    
    func transform(input:Input) -> Output {
        return Output()
        
    }
}
