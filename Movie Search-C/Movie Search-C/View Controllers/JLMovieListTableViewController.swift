//
//  JLMovieListTableViewController.swift
//  Movie Search-C
//
//  Created by Jordan Lamb on 10/11/19.
//  Copyright © 2019 Squanto Inc. All rights reserved.
//

import UIKit

class JLMovieListTableViewController: UITableViewController, UISearchBarDelegate {
    
    var movieResults: [JLMovie] = []

    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 200
        searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text,
            !searchText.isEmpty
            else { return }
        searchBar.resignFirstResponder()
        JLMovieController.sharedInstance().fetchMovies(with: searchText) { (movies) in
            self.movieResults = movies
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieListCell", for: indexPath) as? JLMovieResultTableViewCell else { return UITableViewCell()}
        let movies = movieResults[indexPath.row]
        cell.movieItem = movies
        return cell
    }

}
