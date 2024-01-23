//
//  HapticFeedbackHelper.swift
//  happyday
//
//  Created by Midnight Maverick on 2024/1/23.
//

import Foundation
import UIKit

struct HapticFeedbackHelper {
    static func triggerHapticFeedback(ofType type: UINotificationFeedbackGenerator.FeedbackType = .success) {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(type)
    }
}
