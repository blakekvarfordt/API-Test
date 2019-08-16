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
    
    func fetchMovie(searchTerm: String, completion: @escaping ([Movie?]) -> Void) {
        
        guard let baseURL = URL(string: "https://api.themoviedb.org/3/movie/") else { completion([]); return }
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermItem = URLQueryItem(name: "api_key", value: "feb94c0b93eb522d6e6ac65999f17cbd")
        urlComponents?.queryItems = [searchTermItem]
        
        guard let legitURL = urlComponents?.url else { completion([]); return }
        
        URLSession.shared.dataTask(with: legitURL) { (data, _, error) in
            
            if let error = error {
                print(error)
                print(error.localizedDescription)
                completion([])
            }
            
            guard let data = data else { completion([]); return }
            
            do {
                let movie = try JSONDecoder().decode([Movie].self, from: data)
                completion(movie)
            } catch {
                print(error)
                print(error.localizedDescription)
                completion([])
            }
        }.resume()
    }
    
    
    func fetchImage(item: Movie, completion: @escaping (UIImage?) -> Void) {
        
        guard let imageURL = URL(string: item.imageURL) else { completion(nil); return }
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
