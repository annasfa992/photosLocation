
import Foundation

class ErrorModel: Error {
    
    // MARK: - Properties
    var errorKey: Int
    var message: String
    
    init(_ ErrorKey: Int , _ Message : String ) {
        self.errorKey = ErrorKey
        self.message = Message
    }
}

// MARK: - Public Functions
extension ErrorModel {
    
    
    
    
    class func errorMessage(ErrorCode : Int , ErrorMessage : String) -> ErrorModel{
        
        return ErrorModel(ErrorCode,ErrorMessage)
    }
}





