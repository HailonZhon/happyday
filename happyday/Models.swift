//
//  Models.swift
//  happyday
//
//  Created by Midnight Maverick on 2024/1/23.
//

import Foundation

struct Video: Identifiable, Codable {
    // 使用 'link' 作为唯一标识符
    var id: String { link }
    
    var link: String
    var title: String
    var duration: String
    var author: String
    var viewTimes: String
    var posterUrl: String

    enum CodingKeys: String, CodingKey {
        case link
        case title
        case duration
        case author
        case viewTimes = "view_times"
        case posterUrl = "pic"
    }
}
// 对应于接口返回的 JSON 结构
struct VideoURLResponse: Codable {
    let m3u8_url: String
}


