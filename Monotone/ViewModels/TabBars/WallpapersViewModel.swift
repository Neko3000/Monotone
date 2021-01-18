//
//  WallpapersViewModel.swift
//  Monotone
//
//  Created by Xueliang Chen on 2021/1/17.
//

import Foundation

import RxSwift
import RxRelay
import Action
import RxSwiftExt

class WallpapersViewModel: BaseViewModel, ViewModelStreamable{
    
    // MARK: - Input
    struct Input {
        var selectedWallpaperSize: BehaviorRelay<WallpaperSize> = BehaviorRelay<WallpaperSize>(value: .all)

        var loadMoreAction: Action<Void, [Photo]>?
        var reloadAction: Action<Void, [Photo]>?
    }
    public var input: Input = Input()
    
    // MARK: - Output
    struct Output {
        var photos: BehaviorRelay<[Photo]> = BehaviorRelay<[Photo]>(value: [])
        
        var loadingMore: PublishRelay<Bool> = PublishRelay<Bool>()
        var reloading: PublishRelay<Bool> = PublishRelay<Bool>()
    }
    public var output: Output = Output()
    
    // MARK: - Private
    private var nextLoadPage: Int = 1
    private var currentPhotos: [Photo] = []
    private var emptyPhotos: [Photo] = Array(repeating: Photo(), count: 10)
    
    private var filteredPhotos: [Photo] {
        get{
            let photos = self.currentPhotos.filter { (photo) -> Bool in
                guard let width = photo.width, let height = photo.height else { return true }
                
                return self.input.selectedWallpaperSize.value
                    .adaptWallpaperSize(width: CGFloat(width),height: CGFloat(height))
            }
            
            return photos
        }
    }
    
    // MARK: - Inject
    override func inject(args: [String : Any?]?) {
        //
    }
    
    // MARK: - Bind
    override func bind() {
        
        // Service
        let topicService = self.service(type: TopicService.self)!
        
        // Binding
        // LoadMore.
        self.input.loadMoreAction = Action<Void, [Photo]>(workFactory: { [weak self] _ -> Observable<[Photo]> in
            guard let self = self else { return Observable.empty() }
            
            self.output.loadingMore.accept(true)
            
            // Before the request returns.
            self.output.photos.accept((self.filteredPhotos) + (self.emptyPhotos))
                        
            return topicService.getTopicPhotos(idOrSlug: "wallpapers", page: self.nextLoadPage, perPage: 30)
        })
        
        self.input.loadMoreAction?.elements
            .subscribe(onNext: { [weak self] (photos) in
                guard let self = self else { return }
                
                self.currentPhotos = self.nextLoadPage == 1 ? photos : self.currentPhotos + photos
                self.nextLoadPage += 1

                self.output.photos.accept(self.filteredPhotos)
                
                self.output.loadingMore.accept(false)
            })
            .disposed(by: self.disposeBag)
        
        self.input.loadMoreAction?.errors
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                
                self.output.photos.accept(self.filteredPhotos)

                self.output.loadingMore.accept(false)
            })
            .disposed(by: self.disposeBag)
        
        // Reload.
        self.input.reloadAction = Action<Void, [Photo]>(workFactory: { [weak self](_) -> Observable<[Photo]> in
            guard let self = self else { return Observable.empty() }
            
            self.output.reloading.accept(true)

            if let loadMoreAction = self.input.loadMoreAction{
                self.nextLoadPage = 1
                
                // Before the request returns.
                self.output.photos.accept(self.emptyPhotos)
                
                return loadMoreAction.execute()
            }
            
            return Observable.empty()
        })
        
        self.input.reloadAction?.elements
            .subscribe(onNext: { [weak self] (photos) in
                guard let self = self else { return }
                
                self.output.reloading.accept(false)
            })
            .disposed(by: self.disposeBag)
        
        self.input.reloadAction?.errors
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                
                self.output.reloading.accept(false)
            })
            .disposed(by: self.disposeBag)
        
        // SelectedWallpaperSize.
        self.input.selectedWallpaperSize
            .subscribe(onNext: {[weak self] (wallpaperSize) in
                guard let self = self else { return }
                
                self.output.photos.accept(self.filteredPhotos)
            })
            .disposed(by: self.disposeBag)
        
    }
    
}
