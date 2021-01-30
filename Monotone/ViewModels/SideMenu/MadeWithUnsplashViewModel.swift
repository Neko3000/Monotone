//
//  MadeWithUnsplashViewModel.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/23.
//

import Foundation

import RxSwift
import RxRelay
import Action
import RxSwiftExt

class MadeWithUnsplashViewModel: BaseViewModel, ViewModelStreamable{
    
    // MARK: - Input
    struct Input {
        var categories: BehaviorRelay<[MadeWithUnsplashCategory]?> = BehaviorRelay<[MadeWithUnsplashCategory]?>(value: nil)
        var selectedCategory: BehaviorRelay<MadeWithUnsplashCategory?> = BehaviorRelay<MadeWithUnsplashCategory?>(value: nil)
    }
    public var input: Input = Input()
    
    // MARK: - Output
    struct Output {
        var madeItems: BehaviorRelay<[MadeWithUnsplashItem]?> = BehaviorRelay<[MadeWithUnsplashItem]?>(value: nil)
    }
    public var output: Output = Output()
    
    // MARK: - Private
    //
    
    // MARK: - Inject
    override func inject(args: [String : Any?]?) {
        //
    }
    
    // MARK: - Bind
    override func bind() {
        
        // Service.
        //
        
        // Bindings.
        // SelectedCategory.
        self.input.selectedCategory
            .unwrap()
            .subscribe(onNext:{ [weak self] (category) in
                guard let self = self else { return }
                
                self.output.madeItems.accept(category.rawValue.items)
            })
            .disposed(by: self.disposeBag)
    }
    
}
