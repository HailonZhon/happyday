//
//  Models.swift
//  happyday
//
//  Created by Midnight Maverick on 2024/1/23.
//

import Foundation

struct Video: Identifiable, Codable {
    // 如果您决定使用 `link` 作为唯一标识符
    var id: String { link }
    
    var link: String
    var title: String
    var duration: String
    var m3u8Url: String
    var posterUrl: String

    enum CodingKeys: String, CodingKey {
        case link
        case title
        case duration
        case m3u8Url = "m3u8_url"
        case posterUrl = "poster_url"
    }
}


