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
                  TextField("Search", text: $searchText, onCommit: {
                      // 搜索并收起键盘
                      viewModel.searchVideos(keyword: searchText)
                      dismissKeyboard()
                  })
                  .padding()
                  .textFieldStyle(RoundedBorderTextFieldStyle())

                  Button(action: {
                      // 搜索并收起键盘
                      viewModel.searchVideos(keyword: searchText)
                      dismissKeyboard()
                  }) {
                      Text("Search")
                          .frame(minWidth: 0, maxWidth: .infinity)
                          .padding()
                          .background(Color.blue)
                          .foregroundColor(.white)
                          .cornerRadius(10)
                  }
                .padding()
                
                ScrollView {
                   LazyVGrid(columns: columns, spacing: 20) {
                       ForEach(viewModel.videos, id: \.id) { video in
                           VideoItemView(video: video) {
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
                           .onAppear {
                               if viewModel.videos.isLastItem(video) {
                                   viewModel.loadMoreVideos(keyword: searchText)
                               }
                           }
                       }
                   }.padding(.horizontal)
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
    // 一个方法用来收起键盘
    private func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
extension Array where Element: Identifiable {
    func isLastItem(_ item: Element) -> Bool {
        guard let itemIndex = self.firstIndex(where: { $0.id == item.id }) else {
            return false
        }
        return itemIndex == self.count - 1
    }
}
