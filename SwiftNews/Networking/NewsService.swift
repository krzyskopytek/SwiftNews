//
//  NewsService.swift
//  SwiftNews
//
//  Created by Krzysztof Kopytek on 2020-09-21.
//  Copyright © 2020 Kopytek. All rights reserved.
//

import Foundation

class NewsService: NSObject {
    
    static let shared = NewsService()
    func fetchNews(completion: @escaping (NewsModel?, Error?) -> ()) {
        let urlString = "https://www.reddit.com/r/swift/.json"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                print("Failed to fetch news:", err)
                return
            }
            
            guard let data = data else { return }
            do {
                let swiftNews = try JSONDecoder().decode(NewsModel.self, from: data)
                DispatchQueue.main.async {
                    completion(swiftNews, nil)
                }
            } catch let jsonErr {
                print("Failed to decode:", jsonErr)
            }
            }.resume()
    }
}
