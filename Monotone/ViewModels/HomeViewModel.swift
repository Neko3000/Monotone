//
//  HomeViewModel.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/19.
//

import Foundation

import RxSwift
import RxRelay
import Action

class HomeViewModel: BaseViewModel, ViewModelStreamable{
    
    // MARK: Input
    struct Input {
        var searchQuery: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
        var orderBy: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
        var loadMoreAction: Action<Void, [Photo]>?
        var reloadAction: Action<Void, [Photo]>?
    }
    public var input: Input = Input()
    
    // MARK: Output
    struct Output {
        var photos: BehaviorSubject<[Photo]> = BehaviorSubject<[Photo]>(value: [])
        var loadingMore: BehaviorSubject<Bool> = BehaviorSubject<Bool>(value: false)
        var reloading: BehaviorSubject<Bool> = BehaviorSubject<Bool>(value: false)
    }
    public var output: Output = Output()
    
    // MARK: Private
    private var nextLoadPage: Int = 1
    
    // MARK: Inject
    override func inject(args: [String : Any]?) {
        
    }
    
    // MARK: Bind
    func bind() {
        
    }
    
    
}
