//
//  HomePresenter.swift
//  Movies
//
//  Created by Sergiy Brotsky on 18.01.2023.
//

import Foundation

protocol HomeViewProtocol: AnyObject {
    func updateMovies()
    func showError(message: String)
}

protocol HomePresenterProtocol: AnyObject {
    init(view: HomeViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    
    var currentMovies: MoviesList? {get set}
    var moviesList: [MovieItem] {get set}
    var genres: Genres? {get set}
    var sortType: SortMoviesEnum {get set}
    
    func getGenres()
    func getGenresForMovie(indexPath: IndexPath) -> [String]
    
    func getMovies(isPagination: Bool)
    
    func changeSortingType(type: SortMoviesEnum)
    
    func tabOnMovie()
    
}




class HomePresenter: HomePresenterProtocol {
    
    weak var view: HomeViewProtocol?
    var router: RouterProtocol?
    let networkService: NetworkServiceProtocol!
    
    
    var currentMovies: MoviesList?
    var moviesList: [MovieItem] = []
    var genres: Genres?
    var sortType: SortMoviesEnum = .popular
    
    
    required init(view: HomeViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
    }
    
    // MARK: Genres
    func getGenres() {
        networkService.getGenres { [weak self] result in
            switch result {
                case .success(let genres):
                    self?.genres = genres
                case .failure:
                    break
            }
        }
    }
    
    func getGenresForMovie(indexPath: IndexPath) -> [String] {
        
        guard let genres = genres else { return [] }
        
        let movieItem = moviesList[indexPath.row]
        
        
        let filteredGenres =  genres.genres.filter { genre in
            movieItem.genreIDS.contains(where: {$0 == genre.id})
        }

        
        return filteredGenres.compactMap { genre in
            return genre.name
        }
    }
    
    // MARK: Movies
    func getMovies(isPagination: Bool) {
        let currentPage = currentMovies?.page ?? 0
        let totalPages = currentMovies?.totalPages ?? 0
        // Handle when currentPage bigger then totalPages. It's hard to load 36742 pages, but still))
        let paginationPage = currentPage == totalPages ? currentPage : currentPage + 1
        let page = isPagination ? paginationPage : 1
        
        networkService.getMovies(page: page, sortBy: sortType) { [weak self] result in
            switch result {
                case .success(let movies):
                    print("movies: \(movies)")
                    self?.currentMovies = movies
                    self?.moviesList += movies.results
                    self?.view?.updateMovies()
                case .failure(let error):
                    self?.view?.showError(message: error.localizedDescription)
            }
        }
    }
    
    // MARK: Change sort type
    
    func changeSortingType(type: SortMoviesEnum) {
        sortType = type
        
        currentMovies = nil
        moviesList = []
        
        
        
        getMovies(isPagination: false)
    }
    
    func tabOnMovie() {
        
    }
    
}


