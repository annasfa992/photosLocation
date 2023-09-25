//
//  getPhotosRequestModel.swift
//  photosSelection
//
//  Created by Anas on 25/09/2023.
//

import Foundation
class getPhotosRequestModel: RequestModel {
  
    // MARK: - Properties
    private  var City :String

    init(city:String) {
     
        self.City = city
       

      
    }
    override var path: String {
        return Constants.URLConstants.photosurl
    }
    
    override var headers: [String : String] {
      
      
        return [:]
      }
    override var parameters: [URLQueryItem]{
       
        let queryItems = [URLQueryItem(name: "client_id", value: AppConfig.Constants.accessKey),
                          URLQueryItem(name: "query", value: City)
                          ]
        
       return queryItems
    }

    override var body: [String : Any?] {
       
        return [:]
    }
  
    override var method: RequestHTTPMethod {
        return .get
      }

}
