//
//  PhotoService.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/7.
//

import Foundation

import ObjectMapper
import RxSwift

class PhotoService: NetworkService {

    public func searchPhotos(query:String,
                             page:Int? = 1,
                             perPage:Int? = 10,
                             orderBy:String? = "relevant",
                             collections:[String]? = [],
                             contentFilter:String? = "low",
                             color:String? = "",
                             oritentation:String? = "") -> Observable<[Photo]>{
        
        let request: SearchPhotosRequest = SearchPhotosRequest()
        request.query = query
        request.page = page
        request.perPage = perPage
        
        return Observable.create { (observer) -> Disposable in
            
            NetworkManager.shared.request(request: request , method: .get).subscribe { (json) in
                let response = SearchPhotosResponse(JSON: json)
                let photos = response!.results!
                
                observer.onNext(photos)
                observer.onCompleted()

            } onError: { (error) in
                
                observer.onError(error)
            }.disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
    
    public func listPhotos(page:Int? = 1,
                           perPage:Int? = 10,
                           orderBy:String? = "latest") -> Observable<[Photo]>{
        
        let request: ListPhotosRequest = ListPhotosRequest()
        request.page = page
        request.orderBy = orderBy
        request.perPage = perPage
        
        return Observable.create { (observer) -> Disposable in
            
            NetworkManager.shared.request(request: request, method: .get).subscribe { (json) in
                let response = ListPhotosResponse(JSON: json)
                let photos = response!.results!
                
                observer.onNext(photos)
                observer.onCompleted()

            } onError: { (error) in
                
                observer.onError(error)
            }.disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
    
    public func statisticizePhoto(id: String,
                                  resolution: String? = "days",
                                  quantity: Int? = 30) -> Observable<Statistics>{
        
        let request: StatisticizePhotoRequest = StatisticizePhotoRequest()
        request.id = id
        request.resolution = resolution
        request.quantity = quantity
        
        return Observable.create { (observer) -> Disposable in
            
            NetworkManager.shared.request(request: request, method: .get).subscribe { (json) in
                let response = StatisticizePhotoResponse(JSON: json)
                let statistics = response!.statistics!
                
                observer.onNext(statistics)
                observer.onCompleted()

            } onError: { (error) in
                
                observer.onError(error)
            }.disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
    
    public func likePhoto(id: String) -> Observable<Photo>{
        
        let request: LikePhotoRequest = LikePhotoRequest()
        request.id = id
        
        return Observable.create { (observer) -> Disposable in
            
            NetworkManager.shared.request(request: request, method: .post).subscribe { (json) in
                let response = LikePhotoResponse(JSON: json)
                let photo = response!.photo!
                
                observer.onNext(photo)
                observer.onCompleted()

            } onError: { (error) in
                
                observer.onError(error)
            }.disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
    
    public func unlikePhoto(id: String) -> Observable<Photo>{
        
        let request: UnlikePhotoRequest = UnlikePhotoRequest()
        request.id = id
        
        return Observable.create { (observer) -> Disposable in
            
            NetworkManager.shared.request(request: request, method: .delete).subscribe { (json) in
                let response = UnlikePhotoResponse(JSON: json)
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
