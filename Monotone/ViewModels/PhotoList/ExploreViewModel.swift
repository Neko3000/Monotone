//
//  ExploreViewModel.swift
//  Monotone
//
//  Created by Xueliang Chen on 2021/1/24.
//

import Foundation

import RxSwift
import RxRelay
import Action
import RxSwiftExt

class ExploreViewModel: BaseViewModel, ViewModelStreamable{
    
    // MARK: - Input
    struct Input {
        var explore: BehaviorRelay<UnsplashExplore> = BehaviorRelay<UnsplashExplore>(value: .explore)
    }
    public var input: Input = Input()
    
    // MARK: - Output
    struct Output {
        var sections: BehaviorRelay<[TableViewSection]> = BehaviorRelay<[TableViewSection]>(value: [])
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
        
        // Binding.
        // Explore.
        self.input.explore
            .subscribe(onNext:{ [weak self] (category) in
                guard let self = self else { return }
                
                if(self.input.explore.value == .explore){
                    let sections = ExplorePhotoType.allCases.map { (topicCategory) -> TableViewSection in
                        return TableViewSection(title: topicCategory.rawValue.title,
                                                description: topicCategory.rawValue.description,
                                                items: topicCategory.rawValue.topics ?? [])
                    }
                    self.output.sections.accept(sections)
                }
                else if(self.input.explore.value == .popular){
                    let sections = ExploreCollectionType.allCases.map { (collectionCategory) -> TableViewSection in
                        return TableViewSection(title: collectionCategory.rawValue.title,
                                                description: collectionCategory.rawValue.description,
                                                items: collectionCategory.rawValue.collections ?? [])
                    }
                    self.output.sections.accept(sections)
                }
                
            })
            .disposed(by: self.disposeBag)
        
    }
    
}
