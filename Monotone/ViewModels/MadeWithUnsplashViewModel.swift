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
        var categories: BehaviorRelay<[MadeCategory]?> = BehaviorRelay<[MadeCategory]?>(value: nil)
        var selectedCategory: BehaviorRelay<MadeCategory?> = BehaviorRelay<MadeCategory?>(value: nil)
    }
    public var input: Input = Input()
    
    // MARK: - Output
    struct Output {
        var categories: BehaviorRelay<[MadeCategory]?> = BehaviorRelay<[MadeCategory]?>(value: nil)
        var selectedCategory: BehaviorRelay<MadeCategory?> = BehaviorRelay<MadeCategory?>(value: nil)
        
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
        self.input.categories
            .bind(to: self.output.categories)
            .disposed(by: self.disposeBag)
        
        self.input.selectedCategory
            .bind(to: self.output.selectedCategory)
            .disposed(by: self.disposeBag)
        
        self.input.selectedCategory
            .unwrap()
            .subscribe(onNext:{ [weak self] (category) in
                guard let self = self else { return }
                
                self.output.madeItems.accept(category.rawValue.items)
            })
            .disposed(by: self.disposeBag)
    }
    
}
