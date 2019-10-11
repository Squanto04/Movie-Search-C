//
//  JLMovieResultTableViewCell.swift
//  Movie Search-C
//
//  Created by Jordan Lamb on 10/11/19.
//  Copyright © 2019 Squanto Inc. All rights reserved.
//

import UIKit

class JLMovieResultTableViewCell: UITableViewCell {
    
    var movieItem: JLMovie? {
        didSet {
            updateViews()
        }
    }

    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    
    func updateViews() {
        guard let movieItem = movieItem else { return }
        movieTitleLabel.text = movieItem.title
        movieRatingLabel.text = "Rating: \(movieItem.rating)"
        movieDescriptionLabel.text = movieItem.movieDescription
        movieDescriptionLabel.adjustsFontForContentSizeCategory = true
        movieDescriptionLabel.sizeToFit()
        moviePosterImageView.image = nil
        
        JLMovieController.sharedInstance().fetchImage(movieItem) { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                self.moviePosterImageView.image = image
            }
        }
    }
}
