//
//  PhotoAlbum.swift
//  Monotone
//
//  Created by Xueliang Chen on 2021/2/3.
//

import Foundation
import UIKit
import Photos

class PhotoAlbum{
    // MARK: - Single Skeleton
    public static let shared = PhotoAlbum()
    
    // MARK: - Public
    public static let name = "Monotone"
    
    // MARK: - Priavte
    private var assetCollection: PHAssetCollection!
    
    init() {
        
        if let assetCollection = self.fetchAssetCollectionForAlbum() {
            self.assetCollection = assetCollection
        }
        
        /*
        if PHPhotoLibrary.authorizationStatus() != PHAuthorizationStatus.authorized {
            PHPhotoLibrary.requestAuthorization({ (status: PHAuthorizationStatus) -> Void in
                if(status == .authorized){
                    self.createAlbum()
                }
                else{
                    
                }
            })
        }

        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
            self.createAlbum()
        } else {
            PHPhotoLibrary.requestAuthorization(requestAuthorization)
        }
         */
    }
    
    public func checkAuthorization() -> Bool {
        
        if PHPhotoLibrary.authorizationStatus() != PHAuthorizationStatus.authorized {
            PHPhotoLibrary.requestAuthorization({ (status: PHAuthorizationStatus) -> Void in
                if(status == .authorized){
                    self.createAlbum()
                }
                else{
                    MessageCenter.shared.showMessage(title: NSLocalizedString("uns_photo_ablum_no_authoration_title",
                                                                              comment: "Oops, there was a problem of authentication..."),
                                                     body: NSLocalizedString("uns_photo_ablum_no_authoration_description",
                                                                             comment: "Allow Monotone to access your photos in \"Settings > Privacy > Photos\""),
                                                     theme: .error,
                                                     buttonText: NSLocalizedString("uns_photo_ablum_no_authoration_btn_to_system_settings",
                                                                                   comment: "Settings"),
                                                     buttonTapHandler: {
                                                        
                                                        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }

                                                        if UIApplication.shared.canOpenURL(settingsUrl) {
                                                            UIApplication.shared.open(settingsUrl, completionHandler: nil)
                                                        }
                                                     })
                    

                }
            })
        }
        
        guard PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized else { return false }
        return true
    }
    
    public func save(image: UIImage){
        
        guard self.checkAuthorization() else { return }
        guard self.assetCollection != nil else { return }
        
        PHPhotoLibrary.shared().performChanges({
            let assetChangeRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
            let assetPlaceholder = assetChangeRequest.placeholderForCreatedAsset!
            let albumChangeRequest = PHAssetCollectionChangeRequest(for: self.assetCollection)
            albumChangeRequest?.addAssets([assetPlaceholder] as NSArray)
        }, completionHandler: nil)
    }
    
    private func createAlbum() {
        
        PHPhotoLibrary.shared().performChanges {
            PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: PhotoAlbum.name)
        } completionHandler: { (success, _) in
            if(success){
                self.assetCollection = self.fetchAssetCollectionForAlbum()
            }
        }
    }
    
    private func fetchAssetCollectionForAlbum() -> PHAssetCollection! {
        
        let options = PHFetchOptions()
        options.predicate = NSPredicate(format: "title = %@", PhotoAlbum.name)
        
        let collection = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: options)
        
        if let assetCollection = collection.firstObject{
            return assetCollection
        }
        
        return nil
    }
    
}
