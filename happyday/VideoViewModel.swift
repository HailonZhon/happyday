//
//  VideoViewModel.swift
//  happyday
//
//  Created by Midnight Maverick on 2024/1/23.
//

import Foundation

class VideoViewModel: ObservableObject {
    @Published var videos: [Video] = []
    private var currentPage = 1
    private var canLoadMoreVideos = true
    let videoService = VideoService()

    func searchVideos(keyword: String) {
        currentPage = 1
        canLoadMoreVideos = true
        videos.removeAll()
        loadMoreVideos(keyword: keyword)
    }

    func loadMoreVideos(keyword: String) {
        guard canLoadMoreVideos else { return }
        videoService.fetchVideos(keyword: keyword, page: currentPage) { newVideos in
            if newVideos.isEmpty {
                self.canLoadMoreVideos = false
            } else {
                self.videos.append(contentsOf: newVideos)
                self.currentPage += 1
            }
        }
    }
}

