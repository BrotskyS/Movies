//
//  DetailMoviePresenter.swift
//  Movies
//
//  Created by Sergiy Brotsky on 20.01.2023.
//

import Foundation
import UIKit

protocol DetailMovieViewProtocol: AnyObject {
    func updateMovie(movie: MovieDetail)
    func showError(message: String)
    
    func changeLoaderStatus(isLoading: Bool)
}

protocol DetailMoviePresenterProtocol: AnyObject {
    init(view: DetailMovieViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, movieId: Int)
    
    
    var movie: MovieDetail? {get set}
    var trailerYTKey: String? {get set}
    
    func getMovie()
    
    func openPhoto(image: UIImage?)
}


class DetailMoviePresenter: DetailMoviePresenterProtocol {
    
    weak var view: DetailMovieViewProtocol?
    var router: RouterProtocol?
    let networkService: NetworkServiceProtocol!
    let movieId: Int
    
    var movie: MovieDetail?
    var trailerYTKey: String?
    
    required init(view: DetailMovieViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, movieId: Int) {
        self.view = view
        self.router = router
        self.networkService = networkService
        self.movieId = movieId
    }
    
    func getMovie() {
        view?.changeLoaderStatus(isLoading: true)
        networkService.getMovieDetail(movieId: movieId) { [weak self] result in
            self?.view?.changeLoaderStatus(isLoading: false)
            switch result {
                case .success(let movie):
                    self?.movie = movie
                    self?.setTrailerYTKey()
                    self?.view?.updateMovie(movie: movie)
                case.failure(let error):
                    self?.view?.showError(message: error.localizedDescription)
                    print("DEBUG: networkService.getMovieDetail error: \(error)")
            }
        }
    }
    
    
    
    func openPhoto(image: UIImage?) {
        router?.openImageViewer(image: image)
    }
    
    private func setTrailerYTKey() {
        let videos = movie?.videos.results.filter({ video in
            video.site == "YouTube" && video.type == "Trailer"
        })
        
        let firstVideo = videos?.first
        
        trailerYTKey = firstVideo?.key
    }
    
}
