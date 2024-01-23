//
//  VideoService.swift
//  happyday
//
//  Created by Midnight Maverick on 2024/1/23.
//
import Foundation

class VideoService {
    func fetchVideos(keyword: String, page: Int, completion: @escaping ([Video]) -> Void) {
        let urlString = "http://192.168.28.36:8000/get_videos_by_kw/?keyword=\(keyword)&page=\(page)"

        guard let url = URL(string: urlString) else { return }
        print("Fetching URL: \(urlString)")

        URLSession.shared.dataTask(with: url) { data, response, error in
            print("Received response from network.")
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                return
            }
            guard let data = data else {
                print("No data received from network.")
                return
            }

            print("Response Data: \(String(data: data, encoding: .utf8) ?? "Invalid data")")

            do {
                let videos = try JSONDecoder().decode([Video].self, from: data)
                DispatchQueue.main.async {
                    completion(videos)
                    print("Fetched Videos: \(videos)")
                }
            } catch {
                print("JSON Decoding Error: \(error)")
            }
        }.resume()
    }
    func fetchVideoURL(videoLink: String, completion: @escaping (String?) -> Void) {
        // Modify this URL to your actual video URL fetching endpoint
        let encodedVideoLink = videoLink.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "http://192.168.28.36:8000/get_video_url/?video_link=\(encodedVideoLink)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL: \(urlString)")
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching video URL: \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let data = data else {
                print("No data received.")
                completion(nil)
                return
            }
            
            do {
                let videoURLResponse = try JSONDecoder().decode(VideoURLResponse.self, from: data)
                completion(videoURLResponse.m3u8_url)
            } catch {
                print("JSON Decoding Error: \(error)")
                completion(nil)
            }
        }.resume()
    }
}
