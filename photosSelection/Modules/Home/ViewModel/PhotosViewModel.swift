//
//  PhotosViewModel.swift
//  photosSelection
//
//  Created by Anas on 25/09/2023.
//

import Foundation

class PhotosViewModel : NSObject {
  
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    var bindgetGetphotosViewModelToController : (() -> ()) = {}
    
    private(set) var getphotosData : [PhotosResponseModel]! {
        didSet {
            self.bindgetGetphotosViewModelToController()
        }
    }
    init(city:String) {
        super.init()
        callFuncToGetPhotos(city: city)
    }

    func callFuncToGetPhotos(city:String) {
    
        photosAPI.GetPhotos(city:city){ result in
            switch result {
            case Result.success(let response):
                // Handle successfull response
                
                DispatchQueue.main.async {
                    self.getphotosData = response
                }
                break
            case Result.failure(let error):
                break
            }
        }
    }
}
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
