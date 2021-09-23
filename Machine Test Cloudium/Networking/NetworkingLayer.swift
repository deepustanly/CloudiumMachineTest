//
//  NetworkLayer.swift
//  Machine Test Cloudium
//
//  Created by Deepu Stanly on 21/09/21.
//

import Foundation
import Alamofire

class NetworkingLayer {
    
    var configuration = URLSessionConfiguration.default
    var session: Session
    
    static let shared = NetworkingLayer()
    
    private init() {
        session = Session(configuration: configuration)
    }
    
    func request<T: Decodable>(_ urlConvertible: NetworkRouter, type: T.Type, completion: @escaping (_ result: Response<T>) -> Void) {
        guard NetworkReachabilityManager()!.isReachable else {
            completion(Response(error: NetworkMessages.internetIssue.rawValue, statusCode: 0))
            return
        }
        session.request(urlConvertible).responseData { (response) in
            switch response.result {
            case .success(let data):
                /*
                 * Try creating a JSON
                 */
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let result = try decoder.decode(Response<T>.self, from: data)
                    completion(result)
                    return
                }
                catch {
                    print(error)
                    /*
                     * Failed to create JSON file
                     */
                    completion(Response(error: error.localizedDescription, statusCode: response.response?.statusCode ?? 0))
                    return
                }
                
            case .failure(let error):
                completion(Response(error: error.localizedDescription, statusCode: response.response?.statusCode ?? 0))
            }
        }
    }
    
}
