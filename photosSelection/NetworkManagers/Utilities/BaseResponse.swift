
import Foundation


class BaseResponse : Decodable {
    
    
    var status =  String()
    var copyright =  String()
    var numResults =  Int()

    
    enum CodingKeys: String, CodingKey {
          
        
        
        case status = "status"
        case copyright = "copyright"
        case numResults = "num_results"
       
    
    }
}
