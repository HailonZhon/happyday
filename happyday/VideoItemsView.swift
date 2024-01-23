//
//  VideoItemsView.swift
//  happyday
//
//  Created by Midnight Maverick on 2024/1/23.
//

import Foundation
import SwiftUI
struct VideoItemView: View {
    var video: Video
    var onTapped: () -> Void

    var body: some View {
        VStack {
            ZStack(alignment: .bottomLeading) {
                if let url = URL(string: video.posterUrl) {
                    AsyncImage(url: url)
                        .aspectRatio(contentMode: .fill)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
                Text(video.duration)
                    .font(.subheadline)
                    .padding(6)
                    .background(Color.black.opacity(0.7))
                    .foregroundColor(.white)
                    .cornerRadius(4)
                    .padding(4)
            }
            Text(video.title)
                .font(.headline)
                .lineLimit(1)
                .truncationMode(.tail)
                .multilineTextAlignment(.center)
            Text("作者: \(video.author)")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.top, 2)
            Text("播放次数: \(video.viewTimes)")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.bottom, 2)
        }
        .onTapGesture(perform: onTapped)
    }
}
