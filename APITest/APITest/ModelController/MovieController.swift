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
    
     func fetchMovie(searchTerm: String, completion: @escaping (Bool) -> Void) {
        
        guard let baseURL = URL(string: "https://api.themoviedb.org/3/search/movie") else { completion(false); return }
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchKeyItem = URLQueryItem(name: "api_key", value: "feb94c0b93eb522d6e6ac65999f17cbd")
        let searchTerm = URLQueryItem(name: "query", value: searchTerm)
        urlComponents?.queryItems = [searchKeyItem, searchTerm]
        
        guard let legitURL = urlComponents?.url else { completion(false); return }
        
        print(legitURL)
        
        URLSession.shared.dataTask(with: legitURL) { (data, _, error) in
            
            if let error = error {
                print(error)
                print(error.localizedDescription)
                completion(false)
            }
            
            guard let data = data else { completion(false); return }
            
            do {
                let movie = try JSONDecoder().decode(topLevelMovie.self, from: data)
                completion(true)
                self.movies = movie.results
            } catch {
                print(error)
                print(error.localizedDescription)
                completion(false)
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
            
            let image = UIImage(data: data)
            completion(image)
        }.resume()
    }
    
}
