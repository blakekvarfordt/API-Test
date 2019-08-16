//
//  MovieTableViewController.swift
//  APITest
//
//  Created by Blake kvarfordt on 8/16/19.
//  Copyright © 2019 Blake kvarfordt. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController {

    // Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    var movies = [Movie?]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieTableViewCell
        
        guard let movie = movies[indexPath.row] else { return UITableViewCell()}
        DispatchQueue.main.async {
            
            cell?.titleLabel.text = movie.title
            cell?.ratingLabel.text = movie.rating
            cell?.summaryLabel.text = movie.summary
            
        }
        
 

        return cell ?? UITableViewCell()
    }

}

extension MovieTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        MovieController.fetchMovie(searchTerm: searchTerm) { (movie) in
            
            self.movies = movie
            
            DispatchQueue.main.async {
                
                self.tableView.reloadData()
            }
        }
    }
}
