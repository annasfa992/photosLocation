

import Foundation
import UIKit

class ServiceManager  {
    
    // MARK: - Properties
    public static let shared: ServiceManager = ServiceManager()
    public var baseURL: String = Constants.URLConstants.baseurl
}

// MARK: - Public Functions
extension ServiceManager {
    
    func sendRequest<T: Codable>(request: RequestModel, completion: @escaping(Swift.Result<T, ErrorModel>) -> Void) {
        if request.isLoggingEnabled.0 {
            LogManager.req(request)
        }
        
        /// Comment for rest service
    //    let data = try! Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "Response", ofType: "json")!), options: NSData.ReadingOptions.mappedIfSafe)
        let urlRequest = request.urlRequest()
        print(urlRequest.curlString)
        /// Uncomment for rest service
      URLSession.shared.dataTask(with: urlRequest) { data, response, error in
      guard let data = data, var responseModel = try? JSONDecoder().decode(T.self, from: data) else {
     //   guard var responseModel = try? JSONDecoder().decode(ResponseModel<T>.self, from: data!) else {
        let error: ErrorModel = ErrorModel(500, "")
                LogManager.err(error)

                completion(Result.failure(error))
                return
            }
           let statusCode = ((response as? HTTPURLResponse) != nil) ? (response as! HTTPURLResponse).statusCode :500
        
        
        
        //  responseModel = request

            if request.isLoggingEnabled.1 {
               // LogManager.res(responseModel)
            }
        
        print("responseModel.status ----->\(statusCode)")
        if statusCode == 200 || statusCode == 201  {
                completion(Result.success(responseModel))
            }
        
        else if statusCode == 401{
              DispatchQueue.main.async {
                
               // let alertController = UIAlertController(title: "", message: responseModel.message, preferredStyle: UIAlertController.Style.alert)
//                alertController.addAction(UIAlertAction(title: "Ok".localiz(), style: UIAlertAction.Style.cancel, handler: { _ in
//                        let defaults = UserDefaults.standard
//                        defaults.removeObject(forKey: UserDefaultKeys.Token)
//                        defaults.removeObject(forKey: UserDefaultKeys.UserFullName)
//                        defaults.removeObject(forKey: UserDefaultKeys.searchHistory)
//                        defaults.removeObject(forKey: UserDefaultKeys.profile_picture)
//                        defaults.removeObject(forKey: UserDefaultKeys.cartdType)
//
//                        defaults.synchronize()
//
//                        let sb = UIStoryboard(name: "Main", bundle: nil)
//                                      let homeVC = sb.instantiateViewController(withIdentifier: "LogoutViewController")
//                                      let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                                      appDelegate.window?.rootViewController = homeVC
//                      }))
                  //    alertController.presentInOwnWindow(showOnceOnly: true, animated: true, completion: nil)
              }
            
        }
                      
                
//
                

       else {
        completion(Result.failure(ErrorModel.errorMessage(ErrorCode: statusCode, ErrorMessage:  "")))
            }

        /// Uncomment for rest service
       }.resume()
    }
}

