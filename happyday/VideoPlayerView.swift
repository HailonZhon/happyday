//
//  VideoPlayerView.swift
//  happyday
//
//  Created by Midnight Maverick on 2024/1/23.
//

import Foundation
import SwiftUI
import AVKit

struct VideoPlayerView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        print("Initializing AVPlayer with URL: \(url)")
        let player = AVPlayer(url: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        return playerViewController
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        print("Updating AVPlayerViewController.")
        // 其他更新逻辑（如果有）
    }
}
