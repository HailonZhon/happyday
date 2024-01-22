//
//  VideoService.swift
//  happyday
//
//  Created by Midnight Maverick on 2024/1/23.
//
import Foundation

class VideoService {
    func fetchVideos(keyword: String, completion: @escaping ([Video]) -> Void) {
        let urlString = "http://192.168.28.36:8000/get_videos/?keyword=\(keyword)&page=0"
        guard let url = URL(string: urlString) else { return }
        print("Fetching URL: \(urlString)")

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Network error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            print("Response Data: \(String(data: data, encoding: .utf8) ?? "Invalid data")")

            do {
                let videos = try JSONDecoder().decode([Video].self, from: data)
                DispatchQueue.main.async {
                    completion(videos)
                    print("Fetched Videos: \(videos)")
                    self.saveVideosAsJSON(videos)
                }
            } catch {
                print("JSON Decoding Error: \(error)")
            }
        }.resume()
    }
//    使用缓存Videos构建
    func loadCachedVideos(completion: @escaping ([Video]) -> Void) {
        let fileName = getDocumentsDirectory().appendingPathComponent("videos.json")
        do {
            let jsonData = try Data(contentsOf: fileName)
            let videos = try JSONDecoder().decode([Video].self, from: jsonData)
            completion(videos)
        } catch {
            print("Failed to load cached videos: \(error)")
            completion([]) // 如果加载失败，返回空数组
        }
    }


    private func saveVideosAsJSON(_ videos: [Video]) {
        print("Attempting to save videos as JSON")
        do {
            let jsonData = try JSONEncoder().encode(videos)
            let jsonString = String(data: jsonData, encoding: .utf8)
            let fileName = getDocumentsDirectory().appendingPathComponent("videos.json")
            try jsonString?.write(to: fileName, atomically: true, encoding: .utf8)
            print("Saved to \(fileName.path)")
        } catch {
            print("Failed to save videos as JSON: \(error)")
        }
    }

    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

