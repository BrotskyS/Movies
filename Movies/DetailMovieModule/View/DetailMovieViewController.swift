//
//  DetailMovieViewController.swift
//  Movies
//
//  Created by Sergiy Brotsky on 20.01.2023.
//

import UIKit
import SDWebImage

class DetailMovieViewController: UIViewController {
    
    
    private let  scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "TestImage1")
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .red
        image.translatesAutoresizingMaskIntoConstraints = false
        
        
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .label
        
        return label
    }()
    
    private let countryYearLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .label
        
        return label
    }()
    
    private let genresLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .label
        
        return label
    }()
    
    // ratingStackView
    private let ratingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let trailerImageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "play.rectangle"), for: .normal)
        button.isHidden = true
        
        return button
    }()
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .label
        
        return label
    }()
    
    
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .label
        textView.sizeToFit()
        textView.isScrollEnabled = false
        textView.backgroundColor = .systemBackground
        textView.font = .preferredFont(forTextStyle: .body)
        
        return textView
    }()
    
    
    var presenter: DetailMoviePresenter!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationItem.title = "Title"
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(countryYearLabel)
        stackView.addArrangedSubview(genresLabel)
        
        stackView.addArrangedSubview(ratingStackView)
        ratingStackView.addArrangedSubview(trailerImageButton)
        ratingStackView.addArrangedSubview(ratingLabel)
        
        
        stackView.addArrangedSubview(descriptionTextView)
        
        
        setupConstraints()
        
        presenter.getMovie()
        
    }
    
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            imageView.heightAnchor.constraint(equalToConstant: 300),
            imageView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            
        ])
    }
    
}


extension DetailMovieViewController: DetailMovieViewProtocol {
    func updateMovie(movie: MovieDetail) {
        navigationItem.title = movie.title
        
        if let backdropPath = movie.backdropPath {
            imageView.sd_setImage(with: URL(string: Constant.baseMediaUrl + backdropPath))
        } else {
            imageView.image = UIImage(systemName: "photo.fill")
        }
    
        
        titleLabel.text = movie.title
        
        let counties = movie.productionCountries.compactMap({$0.name}).joined(separator: ", ")
        countryYearLabel.text = "\(counties), \(movie.releaseDate)"
        
        let genres = movie.genres.compactMap({$0.name}).joined(separator: ", ")
        
        genresLabel.text = genres
        
        ratingLabel.text = "Genres: \(movie.voteAverage)"
        
        descriptionTextView.text = movie.overview
    }
    
    func showError(message: String) {
        
    }
    
    func changeLoaderStatus(isLoading: Bool) {
        
    }
    
    
}
