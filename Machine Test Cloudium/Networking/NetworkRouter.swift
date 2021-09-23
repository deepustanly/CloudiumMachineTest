//
//  NetworkRouter.swift
//  Machine Test Cloudium
//
//  Created by Deepu Stanly on 23/09/21.
//

import UIKit
import Foundation
import Alamofire

enum NetworkRouter: URLRequestConvertible {
    
    // MARK: - Endpoints
    case news
    
    // MARK: - Properties
    private var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
  
    private var path: String {
        switch self {
        case .news:
            return "mostpopular/v2/viewed/7.json"
        }
    }
  
    private var queryParameters: Parameters? {
        switch self {
        case .news:
            return ["api-key": "DM3QCzJA779BPXwqBqvjHBI9zgOuWQqm"]
        default:
            return nil
        }
    }
    
    private var body: Parameters? {
        switch self {
        default:
            return nil
        }
    }
    
    // MARK: - Methods
    func asURLRequest() throws -> URLRequest {
        // Construct url
        let url = try "https://api.nytimes.com/svc/".asURL()
            
        // Append path
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // Determine HTTP method
        urlRequest.httpMethod = method.rawValue
        
        // Set common headers
        urlRequest.setValue(NetworkConstants.HTTPHeaderFieldValue.json.rawValue,
                            forHTTPHeaderField: NetworkConstants.HTTPHeaderFieldKey.acceptType.rawValue)
        urlRequest.setValue(NetworkConstants.HTTPHeaderFieldValue.json.rawValue,
                            forHTTPHeaderField: NetworkConstants.HTTPHeaderFieldKey.contentType.rawValue)
        // Add http body to request
        if let body = body {
            do {
                let data = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
                urlRequest.httpBody = data
                print(String(data: data, encoding: .utf8) ?? "")
            } catch (_) {
                print("APIRouter: Failed to parse body into request.")
            }
        }
        
        // Add query parameters to request
        if let parameters = queryParameters {
            urlRequest = try URLEncoding.queryString.encode(urlRequest, with: parameters)
        }
        return urlRequest
    }
}
