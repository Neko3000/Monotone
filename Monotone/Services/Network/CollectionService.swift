//
//  CollectionService.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/11.
//

import Foundation

import ObjectMapper
import RxSwift

class CollectionService: NetworkService {
    
    public func listCollections(page:Int? = 1,
                                perPage:Int? = 10) -> Observable<[Collection]>{
        
        let request: ListCollectionsRequest = ListCollectionsRequest()
        request.page = page
        request.perPage = perPage
        
        return Observable.create { (observer) -> Disposable in
            
            NetworkManager.shared.request(request: request , method: .get).subscribe { (json) in
                let response = ListCollectionsResponse(JSON: json)
                let collections = response!.results!
                
                observer.onNext(collections)
                observer.onCompleted()

            } onError: { (error) in
                
                observer.onError(error)
            }.disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
    
    public func getCollectionPhotos(id: String,
                                    page: Int? = 1,
                                    perPage: Int? = 10,
                                    orientation:String? = nil) -> Observable<[Photo]>{
        
        let request: GetCollectionPhotosRequest = GetCollectionPhotosRequest()
        request.id = id
        request.page = page
        request.perPage = perPage
        request.orientation = orientation

        return Observable.create { (observer) -> Disposable in
            
            NetworkManager.shared.request(request: request , method: .get).subscribe { (json) in
                let response = GetCollectionPhotosResponse(JSON: json)
                let photos = response!.results!
                
                observer.onNext(photos)
                observer.onCompleted()

            } onError: { (error) in
                
                observer.onError(error)
            }.disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }

    public func createCollection(title: String,
                                 description: String? = "",
                                 isPrivate: Bool? = false) -> Observable<Collection?>{
        
        let request: CreateCollectionRequest = CreateCollectionRequest()
        request.title = title
        request.description = description
        request.isPrivate = isPrivate
        
        return Observable.create { (observer) -> Disposable in
            
            NetworkManager.shared.request(request: request , method: .post).subscribe { (json) in
                let response = CreateCollectionResponse(JSON: json)
                let collection = response!.collection!
                
                observer.onNext(collection)
                observer.onCompleted()

            } onError: { (error) in
                
                observer.onError(error)
            }.disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
    
    public func addToCollection(collectionId: String,
                                photoId: String) -> Observable<Photo?>{
        
        let request: AddToCollectionRequest = AddToCollectionRequest()
        request.collectionId = collectionId
        request.photoId = photoId
        
        return Observable.create { (observer) -> Disposable in
            
            NetworkManager.shared.request(request: request , method: .post).subscribe { (json) in
                let response = AddToCollectionResponse(JSON: json)
                let photo = response!.photo!
                
                observer.onNext(photo)
                observer.onCompleted()

            } onError: { (error) in
                
                observer.onError(error)
            }.disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
    
    public func removeFromCollection(collectionId: String,
                                     photoId: String) -> Observable<Photo?>{
        
        let request: RemoveFromCollectionRequest = RemoveFromCollectionRequest()
        request.collectionId = collectionId
        request.photoId = photoId
        
        return Observable.create { (observer) -> Disposable in
            
            NetworkManager.shared.request(request: request , method: .delete).subscribe { (json) in
                let response = RemoveFromCollectionResponse(JSON: json)
                let photo = response!.photo!
                
                observer.onNext(photo)
                observer.onCompleted()

            } onError: { (error) in
                
                observer.onError(error)
            }.disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
}
