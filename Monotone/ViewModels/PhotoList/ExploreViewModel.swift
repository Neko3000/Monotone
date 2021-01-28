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
        var explore: BehaviorRelay<UnsplashExplore?> = BehaviorRelay<UnsplashExplore?>(value: nil)
        // var loadPhotosAction: Action<Void, Void>?
        var loadCollectionsAction: Action<Void, Void>?
    }
    public var input: Input = Input()
    
    // MARK: - Output
    struct Output {
        var sections: BehaviorRelay<[TableViewSection]> = BehaviorRelay<[TableViewSection]>(value: [])
    }
    public var output: Output = Output()
    
    // MARK: - Private
    private var photoTypeSections: [TableViewSection]!
    
    private var collectionTypeSections: [TableViewSection]!
    private var emptyCollections: [Collection] = Array(repeating: Collection(), count: 10)

    // MARK: - Inject
    override func inject(args: [String : Any?]?) {
        //
    }
    
    // MARK: - Bind
    override func bind() {
        
        // Service.
        let collectionService = self.service(type: CollectionService.self)!
        
        // Binding.
        // PhotoTypeSections.
        self.photoTypeSections = ExplorePhotoType.allCases.map { (photoType) -> TableViewSection in
            return TableViewSection(key:photoType.rawValue.key,
                                    title: photoType.rawValue.title,
                                    description: photoType.rawValue.description,
                                    items: [photoType])
        }
        
        // self.input.loadPhotosAction = ...
        
        // CollectionTypeSection.
        self.collectionTypeSections = ExploreCollectionType.allCases.map { (collectionType) -> TableViewSection in
            return TableViewSection(key:collectionType.rawValue.key,
                                    title: collectionType.rawValue.title,
                                    description: collectionType.rawValue.description,
                                    items: self.emptyCollections)
        }
        
        self.input.loadCollectionsAction = Action<Void, Void>(workFactory: { [weak self] (_) -> Observable<Void> in
            guard let self = self else { return Observable.empty() }

            ExploreCollectionType.allCases.forEach { (collectionType) in
                collectionService.searchCollections(query: collectionType.rawValue.key)
                    .subscribe(onNext:{ (photos) in
                        let index = self.collectionTypeSections.firstIndex { (section) -> Bool in
                            section.key == collectionType.rawValue.key
                        }
                        self.collectionTypeSections[index!].items = photos.choose(5)
                        
                        if(self.input.explore.value == .popular){
                            self.output.sections.accept(self.collectionTypeSections)
                        }
                    })
                    .disposed(by: self.disposeBag)
            }
            
            return Observable.just(Void())
        })
                
        // Explore.
        self.input.explore
            .unwrap()
            .subscribe(onNext:{ [weak self] (category) in
                guard let self = self else { return }
                
                if(self.input.explore.value == .explore){
                    // self.input.loadPhotosAction?.execute()
                    self.output.sections.accept(self.photoTypeSections)
                }
                else if(self.input.explore.value == .popular){
                    self.input.loadCollectionsAction?.execute()
                    self.output.sections.accept(self.collectionTypeSections)
                }
                
            })
            .disposed(by: self.disposeBag)
        
    }
}
