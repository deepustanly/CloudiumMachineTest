//
//  Photo.swift
//  Machine Test Cloudium
//
//  Created by Deepu Stanly on 21/09/21.
//

struct Photo: Decodable {
    let url :String
    let height :Int
    let width :Int
    
    enum CodingKeys: String, CodingKey {
        case url
        case height
        case width
    }
}
