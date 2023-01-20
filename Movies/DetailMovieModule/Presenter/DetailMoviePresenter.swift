//
//  DetailMoviePresenter.swift
//  Movies
//
//  Created by Sergiy Brotsky on 20.01.2023.
//

import Foundation

protocol DetailMovieViewProtocol: AnyObject {
    func updateMovie(movie: MovieDetail)
    func showError(message: String)
    
    func changeLoaderStatus(isLoading: Bool)
}

protocol DetailMoviePresenterProtocol: AnyObject {
    init(view: DetailMovieViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, movieId: Int)
    
    
    var movie: MovieDetail? {get set}
    
    func getMovie()
    
}


class DetailMoviePresenter: DetailMoviePresenterProtocol {
    
    weak var view: DetailMovieViewProtocol?
    var router: RouterProtocol?
    let networkService: NetworkServiceProtocol!
    let movieId: Int
    
    var movie: MovieDetail?
    
    required init(view: DetailMovieViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, movieId: Int) {
        self.view = view
        self.router = router
        self.networkService = networkService
        self.movieId = movieId
    }
    
    func getMovie() {
        networkService.getMovieDetail(movieId: movieId) { [weak self] result in
            switch result {
                case .success(let movie):
                    self?.movie = movie
                    self?.view?.updateMovie(movie: movie)
                case.failure(let error):
                    self?.view?.showError(message: error.localizedDescription)
                    print("DEBUG: networkService.getMovieDetail error: \(error)")
            }
        }
    }
    
}
