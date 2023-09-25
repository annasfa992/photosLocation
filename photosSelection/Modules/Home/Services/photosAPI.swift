//
//  photosAPI.swift
//  photosSelection
//
//  Created by Anas on 25/09/2023.
//

import Foundation
class photosAPI : NSObject {
    class func GetPhotos(city:String,completion: @escaping(Swift.Result<[PhotosResponseModel], ErrorModel>) -> Void) {
        ServiceManager.shared.sendRequest(request: getPhotosRequestModel(city: city)) { (result) in
            completion(result)
        }
    }
}
