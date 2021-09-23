//
//  news.swift
//  Machine Test Cloudium
//
//  Created by Deepu Stanly on 21/09/21.
//
import Foundation

struct News: Decodable {
    let id: Int
    let title: String
    let url: String
    let author: String
    let abstract: String
    let updatedDate: String
    let media: [Media]
    let section : String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case url
        case author = "byline"
        case abstract
        case updatedDate = "updated"
        case media
        case section
    }
    
    var date: String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatterGet.timeZone = TimeZone.current
        dateFormatterGet.locale = Locale.current
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatterGet.date(from: updatedDate) {
            return dateFormatterPrint.string(from: date)
        } else{
            return updatedDate
        }
    }
}


