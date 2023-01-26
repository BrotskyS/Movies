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
    
    func changeLoaderStatus(isLoading: Bool)
}

protocol HomePresenterProtocol: AnyObject {
    init(view: HomeViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    
    var currentMovies: MoviesList? {get set}
    var moviesList: [MovieItem] {get set}
    var genres: Genres? {get set}
    var sortType: SortMoviesEnum {get set}
    var searchText: String {get set}
    
    // genres
    func getGenres()
    func getGenresForMovie(indexPath: IndexPath) -> [String]
    
    // movies
    func getMovies(isPagination: Bool)
    
    // sort
    func changeSortingType(type: SortMoviesEnum)
    
    // search
    func updateSearchText(searchText: String)
    
    func didSelectMovieMovie(at indexPath: IndexPath)
    
}

class HomePresenter: HomePresenterProtocol {
    
    weak var view: HomeViewProtocol?
    var router: RouterProtocol?
    let networkService: NetworkServiceProtocol!
    
    var currentMovies: MoviesList?
    var moviesList: [MovieItem] = []
    var genres: Genres?
    var sortType: SortMoviesEnum = .popular
    var searchText: String = ""
    
    required init(view: HomeViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
    }
    
    // MARK: Genres
    func getGenres() {
        view?.changeLoaderStatus(isLoading: true)
        
        networkService.getGenres { [weak self] result in
            self?.view?.changeLoaderStatus(isLoading: false)
            
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
        
        view?.changeLoaderStatus(isLoading: true)
        
        let currentPage = currentMovies?.page ?? 0
        let totalPages = currentMovies?.totalPages ?? 0
        // Handle when currentPage bigger then totalPages. It's hard to load 36742 pages, but still))
        let paginationPage = currentPage == totalPages ? currentPage : currentPage + 1
        let page = isPagination ? paginationPage : 1
        
        // Check if it's search request
        
        if searchText.isEmpty {
            networkService.getMovies(page: page, sortBy: sortType) { [weak self] result in
                self?.view?.changeLoaderStatus(isLoading: false)
                switch result {
                case .success(let movies):
                    self?.currentMovies = movies
                    
                    if movies.page == 1 {
                        self?.moviesList = movies.results
                    } else {
                        self?.moviesList += movies.results
                    }
                    
                    self?.view?.updateMovies()
                    
                case .failure(let error):
                    print("DEBUG: networkService.getMovies error: \(error)")
                    self?.view?.showError(message: error.localizedDescription)
                }
            }
        } else {
            networkService.getSearchedMovies(page: page, query: searchText) { [weak self] result in
                self?.view?.changeLoaderStatus(isLoading: false)
                
                switch result {
                case .success(let movies):
                    self?.currentMovies = movies
                    
                    if movies.page == 1 {
                        self?.moviesList = movies.results
                    } else {
                        self?.moviesList += movies.results
                    }
                    
                    self?.view?.updateMovies()
                case .failure(let error):
                    print("DEBUG: networkService.getSearchedMovies error: \(error)")
                    self?.view?.showError(message: error.localizedDescription)
                }
            }
        }
        
    }
    
    // MARK: Change sort type
    
    func changeSortingType(type: SortMoviesEnum) {
        sortType = type
        
        getMovies(isPagination: false)
    }
    
    func updateSearchText(searchText: String) {
        self.searchText = searchText
        
        getMovies(isPagination: false)
    }
    
    func didSelectMovieMovie(at indexPath: IndexPath) {
        let movieId = moviesList[indexPath.row].id
        
        router?.showDetailMovie(movieId: movieId)
    }
    
    private func clearMovies() {
        currentMovies = nil
        moviesList = []
    }
}
