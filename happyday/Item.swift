//
//  Item.swift
//  happyday
//
//  Created by Midnight Maverick on 2024/1/22.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
