//
//  Media.swift
//  Machine Test Cloudium
//
//  Created by Deepu Stanly on 21/09/21.
//

struct Media: Decodable {
    let photos : [Photo]
    
    enum CodingKeys: String, CodingKey {
        case photos = "media-metadata"
    }
}
