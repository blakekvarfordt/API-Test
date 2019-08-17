//
//  Movie.swift
//  APITest
//
//  Created by Blake kvarfordt on 8/16/19.
//  Copyright © 2019 Blake kvarfordt. All rights reserved.
//

import Foundation

struct topLevelMovie: Decodable {
    let results: [Movie]
}


struct Movie: Decodable {
    let title: String
    let rating: Double
    let summary: String
    let imageURL: String?
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case title
        case rating = "vote_average"
        case summary = "overview"
        case id
        case imageURL = "poster_path"
    }
}
