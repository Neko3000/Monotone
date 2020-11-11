//
//  UnsplashPhotoService.swift
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
        
        return Observable.create { (observer) -> Disposable in
            
            NetworkManager.shared.request(request: request, method: .get).subscribe { (json) in
                let response = SearchPhotosResponse(JSON: json)
                
                observer.onNext(response!.results!)
                observer.onCompleted()

            } onError: { (error) in
                
                observer.onError(error)
            }.disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
    
    public func listPhotos(page:Int? = 1,
                           perPage:Int? = 10,
                           orderBy:String? = "lastest")->Observable<[Photo]>{
        
        let request: ListPhotosRequest = ListPhotosRequest()
        request.page = page
        request.orderBy = orderBy
        
        return Observable.create { (observer) -> Disposable in
            
            NetworkManager.shared.request(request: request, method: .get).subscribe { (json) in
                let response = ListPhotosResponse(JSON: json)
                
                observer.onNext(response!.results!)
                observer.onCompleted()

            } onError: { (error) in
                
                observer.onError(error)
            }.disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
}
