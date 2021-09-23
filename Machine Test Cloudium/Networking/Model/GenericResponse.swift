//
//  GenericResponse.swift
//  Machine Test Cloudium
//
//  Created by Deepu Stanly on 23/09/21.
//

import Foundation

struct Response<T: Decodable>: Decodable {

    let isSuccess   : Bool
    let status      : String
    let message     : String
    var results     : T? = nil
    
    enum CodingKeys: String, CodingKey {
        case isSuccess
        case status
        case message = "copyright"
        case results
    }
    
    init(from decoder: Decoder) throws {
        let container       = try decoder.container(keyedBy: CodingKeys.self)
        self.isSuccess      = (try? container.decodeIfPresent(Bool.self, forKey: .isSuccess)) ?? false
        self.status         = (try? container.decodeIfPresent(String.self, forKey: .status)) ?? ""
        self.message        = (try? container.decodeIfPresent(String.self, forKey: .message)) ?? ""
        if let results = try container.decodeIfPresent(T.self, forKey: .results) {
            self.results = results
        }
    }
    
    init(error: String, statusCode: Int) {
        self.isSuccess = false
        self.message = error
        self.status = "\(statusCode)"
        self.results = nil
    }
    
}
