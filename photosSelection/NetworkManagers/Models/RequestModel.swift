
import Foundation
import UIKit

enum RequestHTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = " DELETE"
    
    
    func getRequest() -> String {
         return self.rawValue
     }
    
}

class RequestModel: NSObject {
    private func percentEscapeString(_ string: String) -> String {
       var characterSet = CharacterSet.alphanumerics
       characterSet.insert(charactersIn: "-._* ")
       
       return string
         .addingPercentEncoding(withAllowedCharacters: characterSet)!
         .replacingOccurrences(of: " ", with: "+")
         .replacingOccurrences(of: " ", with: "+", options: [], range: nil)
     }
     
    // MARK: - Properties
    var path: String {
        return ""
    }
    var parameters: [URLQueryItem] {
        return parameters
    }
    var headers: [String: String] {
        return [:]
    }
    var method: RequestHTTPMethod {
        
        return method
    }
    var postBody: String {
        return ""
    }
 
    var body: [String: Any?] {
        return [:]
    }
    
    // (request, response)
    var isLoggingEnabled: (Bool, Bool) {
        return (true, true)
    }
}

// MARK: - Public Functions
extension RequestModel {
    
    func urlRequest() -> URLRequest {
        var endpoint: String = ServiceManager.shared.baseURL.appending(path)
        let queryItems = parameters
    
       
        
//        for parameter in parameters {
//          
//            if let value = parameter.value as? String {
//                endpoint.append("&\(parameter.key)=\(value)")
//                
//            }
//        }
        let escapedString = endpoint.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        let url =  URL(string: escapedString!) 
        
        let newUrl =  (url?.appe(queryItems))!
        var request: URLRequest = URLRequest(url:newUrl)
        
        request.httpMethod = method.rawValue
        
        for header in headers {
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
        
        if method == RequestHTTPMethod.post  ||  method == RequestHTTPMethod.put || method == RequestHTTPMethod.delete{
            do {

                    let jsonData = try? JSONSerialization.data(withJSONObject: body)
                    request.httpBody = jsonData
  
            } catch let error {
                LogManager.e("Request body parse error: \(error.localizedDescription)")
            }
        }
        
        return request
    }
}

extension URLRequest {

    /**
     Returns a cURL command representation of this URL request.
     */
    public var curlString: String {
        
        guard let url = url else { return "" }
        var baseCommand = #"curl "\#(url.absoluteString)""#

        if httpMethod == "HEAD" {
            baseCommand += " --head"
        }

        var command = [baseCommand]

        if let method = httpMethod, method != "GET" && method != "HEAD" {
            command.append("-X \(method)")
        }

        if let headers = allHTTPHeaderFields {
            for (key, value) in headers where key != "Cookie" {
                command.append("-H '\(key): \(value)'")
            }
        }

        if let data = httpBody, let body = String(data: data, encoding: .utf8) {
            command.append("-d '\(body)'")
        }

        return command.joined(separator: " \\\n\t")
    }

}

extension URL {
    /// Returns a new URL by adding the query items, or nil if the URL doesn't support it.
    /// URL must conform to RFC 3986.
    func appe(_ queryItems: [URLQueryItem]) -> URL? {
        guard var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            // URL is not conforming to RFC 3986 (maybe it is only conforming to RFC 1808, RFC 1738, and RFC 2732)
            return nil
        }
        // append the query items to the existing ones
        urlComponents.queryItems = (urlComponents.queryItems ?? []) + queryItems

        // return the url from new url components
        return urlComponents.url
    }
}
