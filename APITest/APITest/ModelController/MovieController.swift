//
//  MovieController.swift
//  APITest
//
//  Created by Blake kvarfordt on 8/16/19.
//  Copyright © 2019 Blake kvarfordt. All rights reserved.
//

import Foundation
import UIKit.UIImage

class MovieController {
    
    static let shared = MovieController()
    
    var movies = [Movie]()
    
     func fetchMovie(searchTerm: String, completion: @escaping ([Movie]?) -> Void) {
        
        guard let baseURL = URL(string: "https://api.themoviedb.org/3/search/movie") else { completion(nil); return }
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchKeyItem = URLQueryItem(name: "api_key", value: "dc04668d9b35cc4b795295b61bf26e69")
        let searchTerm = URLQueryItem(name: "query", value: searchTerm)
        urlComponents?.queryItems = [searchKeyItem, searchTerm]
        
        guard let legitURL = urlComponents?.url else { completion(nil); return }
        
        print(legitURL)
        
        URLSession.shared.dataTask(with: legitURL) { (data, _, error) in
            
            if let error = error {
                print(error)
                print(error.localizedDescription)
                completion(nil)
            }
            
            guard let data = data else { completion(nil); return }
            
            do {
                let movie = try JSONDecoder().decode(topLevelMovie.self, from: data)
                completion(movie.results)
                self.movies = movie.results
            } catch {
                print(error)
                print(error.localizedDescription)
                completion(nil)
            }
        }.resume()
    }
    
    
     func fetchImage(item: Movie, completion: @escaping (UIImage?) -> Void) {
        guard let imageString = item.imageURL else { completion(nil); return }
        guard let imageURL = URL(string: imageString) else { completion(nil); return }
        print(imageURL)
        
        URLSession.shared.dataTask(with: imageURL) { (data, _, error) in
            
            if let error = error {
                print(error)
                print(error.localizedDescription)
                completion(nil)
            }
            
            guard let data = data else { completion(nil); return }
            
            guard let image = UIImage(data: data) else { completion(nil); return }
            
            completion(image)
        }.resume()
    }
    
}
