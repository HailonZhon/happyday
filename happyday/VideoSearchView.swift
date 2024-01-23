import SwiftUI

struct VideoSearchView: View {
    @State private var searchText = ""
    @State private var isShowingPlayer = false
    @State private var selectedVideoUrl: URL?
    @ObservedObject var viewModel = VideoViewModel()

    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

    var body: some View {
        NavigationView {
            VStack {
                TextField("Search", text: $searchText)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button("Search") {
                    viewModel.searchVideos(keyword: searchText)
                }
                .padding()

                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(viewModel.videos, id: \.id) { video in
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
                            .onTapGesture {
                                print("User tapped on video: \(video.title)")
                                viewModel.videoService.fetchVideoURL(videoLink: video.link) { videoURL in
                                    if let videoURL = videoURL {
                                        print("Received video URL for playback: \(videoURL)")
                                        self.selectedVideoUrl = URL(string: videoURL)
                                        self.isShowingPlayer = true
                                    } else {
                                        print("Failed to receive video URL for \(video.title)")
                                    }
                                }
                            }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .navigationBarTitle("Video Search")
            .sheet(isPresented: $isShowingPlayer) {
                if let url = selectedVideoUrl {
                    VideoPlayerView(url: url)
                }
            }
        }
    }

