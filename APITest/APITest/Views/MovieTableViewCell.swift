//
//  MovieTableViewCell.swift
//  APITest
//
//  Created by Blake kvarfordt on 8/16/19.
//  Copyright © 2019 Blake kvarfordt. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    // Outlets
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    // Properties
    var movie: Movie? {
        didSet {
            setupViews()
            imageQuery()
        }
    }
    
    
    func setupViews() {
        guard let movie = movie else { return }
        titleLabel.text = movie.title
        ratingLabel.text = "\(movie.rating)"
        summaryLabel.text = movie.summary
    }
    
    func imageQuery() {
        guard let item = movie else { return }
        MovieController.shared.fetchImage(item: item) { (image) in
            if image != nil {
                DispatchQueue.main.async {
                    self.movieImageView.image = image
                }
            }
        }
    }

}
