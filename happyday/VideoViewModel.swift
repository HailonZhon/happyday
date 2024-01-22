//
//  VideoViewModel.swift
//  happyday
//
//  Created by Midnight Maverick on 2024/1/23.
//

import Foundation
class VideoViewModel: ObservableObject {
    @Published var videos: [Video] = []
    private var videoService = VideoService()

    func searchVideos(keyword: String) {
        videoService.fetchVideos(keyword: keyword) { videos in
            self.videos = videos
        }
    }
//    使用缓存构建
    func loadCachedVideos() {
            videoService.loadCachedVideos { videos in
                DispatchQueue.main.async {
                    self.videos = videos
                }
            }
        }
}