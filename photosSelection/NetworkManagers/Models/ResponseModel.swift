
import Foundation
struct ResponseModel<T: Codable>: Codable {
    
    // MARK: - Properties

   
    let code : Int?
    let data : T?
    let message : String?
    let success : Bool?
    let url : String?
    
       var request: RequestModel?
    
    
    public init(from decoder: Decoder) throws {
        let keyedContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
        data = try? keyedContainer.decode(T.self, forKey: CodingKeys.data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        
      
    }
}

// MARK: - Private Functions
extension ResponseModel {
    
    private enum CodingKeys: String, CodingKey {
        
        case code = "code"
        case data = "data"
        case message = "message"
        case success = "success"
        case url = "url"
        
    }
}

