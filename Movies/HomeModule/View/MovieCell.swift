//
//  MovieCell.swift
//  Movies
//
//  Created by Sergiy Brotsky on 19.01.2023.
//

import Foundation
import UIKit
import SDWebImage

class MovieCell: UITableViewCell {
    
    static let identifier = "movieCell"
    
    private let view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.masksToBounds = false
        
        return view
    }()
    
    private let backgroundImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        
        return image
    }()
    
    private let titleView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 2
        
        label.setShadow()
        
        return label
    }()
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
  
        label.setShadow()
        
        return label
        
    }()
    
    private let genresLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        
        label.setShadow()
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(view)
        
        view.addSubview(backgroundImageView)
        view.addSubview(titleView)
        view.addSubview(ratingLabel)
        view.addSubview(genresLabel)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func configure(movie: MovieItem, genres: [String]) {
        titleView.text = movie.title + ", \n" + (movie.releaseDate ?? "")
        
        if let backdropPath = movie.backdropPath {
            backgroundImageView.sd_setImage(with: URL(string: Constant.baseMediaUrl + backdropPath))
            backgroundImageView.sd_imageTransition = .fade
        } else {
            backgroundImageView.image = UIImage(systemName: "photo.fill")
        }
       
        ratingLabel.text = "Rating: \(movie.voteAverage)"
        
        genresLabel.text = genres.joined(separator: "\n")
        genresLabel.numberOfLines = genres.count
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // View
            view.widthAnchor.constraint(equalTo: widthAnchor, constant: -20),
            view.heightAnchor.constraint(equalTo: heightAnchor, constant: -20),
            view.centerYAnchor.constraint(equalTo: centerYAnchor),
            view.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            // Title
            titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            titleView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20),
            
            // Image
            backgroundImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            backgroundImageView.heightAnchor.constraint(equalTo: view.heightAnchor),
            
            // ratingLabel
            ratingLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            ratingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // genresLabel
            genresLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            genresLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
    
}
