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
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieController.shared.movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        
        let movie = MovieController.shared.movies[indexPath.row]
        
        cell.movie = movie
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension MovieTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        MovieController.shared.fetchMovie(searchTerm: searchTerm) { (movies) in
            if movies != nil {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}
