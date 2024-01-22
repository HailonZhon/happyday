import SwiftUI

struct VideoSearchView: View {
//    @State private var searchText = ""
//    @State private var isShowingPlayer = false
//    @State private var selectedVideoUrl: URL?
//    @ObservedObject var viewModel = VideoViewModel()
//    使用缓存构建
    @State private var searchText = ""
    @State private var isShowingPlayer = false
    @State private var selectedVideoUrl: URL?
    @State private var showingCacheAlert = false // 新增状态变量
    @ObservedObject var viewModel = VideoViewModel()

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Search", text: $searchText)
                        .padding()

//                    Button(action: {
//                        viewModel.searchVideos(keyword: searchText)
//                    }) {
//                        Text("Submit")
//                    }
//                    .padding()
                    Button(action: {
                              showingCacheAlert = true // 显示询问是否使用缓存的弹窗
                          }) {
                              Text("Submit")
                          }
                          .padding()
                          .alert(isPresented: $showingCacheAlert) {
                              Alert(
                                  title: Text("Use Cached Data?"),
                                  message: Text("Would you like to use cached data for this search?"),
                                  primaryButton: .default(Text("Use Cache")) {
                                      viewModel.loadCachedVideos()
                                  },
                                  secondaryButton: .cancel(Text("Search Online")) {
                                      viewModel.searchVideos(keyword: searchText)
                                  }
                              )
                          }
                }

                List(viewModel.videos, id: \.id) { video in
                    VStack(alignment: .leading) {
                        Text(video.title)
                        Text(video.duration)
                        if let url = URL(string: video.posterUrl) {
                            AsyncImage(url: url)
                                .frame(width: 100, height: 100)
                        }
                        Button("Play Video") {
                            selectedVideoUrl = URL(string: video.m3u8Url)
                            isShowingPlayer = true
                        }
                    }
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
}


