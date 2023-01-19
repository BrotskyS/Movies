//
//  HomeViewController.swift
//  Movies
//
//  Created by Sergiy Brotsky on 18.01.2023.
//

import UIKit

class HomeViewController: UIViewController {

    private let searchController = UISearchController(searchResultsController: nil)
    private let tableView = UITableView()
    
    
    private let uiMenu: UIMenu = {
        let menu = UIMenu(title: "Hello", options: .displayInline, children: [
            UIAction(title: "asdasd", handler: { item in
                item.state = .on
            }),
            
            UIAction(title: "1111", handler: { _ in
                
            })
        ])
        
        return menu
    }()
    
    var presenter: HomePresenterProtocol!
    
    var rightBarButtonItem = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        setupNavigationItem()
        setupTableView()
        
     
        presenter.getGenres()
        presenter.getMovies(isPagination: false)
    }
    
    private func setupNavigationItem() {
        navigationItem.title = "Popular Movies"
        navigationItem.searchController = searchController
        
        rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), menu: createMenu())
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        
        searchController.searchBar.delegate = self
        
        
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 350
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
        
        
        NSLayoutConstraint.activate([
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
    
    
 
    
    @objc func tappedOnRightBarButtonItem() {
        print("tappedOnRightBarButtonItem")
    }
}


// MARK: HomeViewProtocol
extension HomeViewController: HomeViewProtocol {
    func updateMovies() {
        tableView.reloadData()
    }
    
    func showError(message: String) {
        
    }
    
}


// MARK: UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Hello")
    }
}
// MARK: UITableViewDelegate, UITableViewDataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.moviesList.count
    }
    
    // render cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        
        
         
        let movieItem =  presenter.moviesList[indexPath.row]
        
        let genres = presenter.getGenresForMovie(indexPath: indexPath)
    
        
        cell.configure(movie: movieItem, genres: genres)
        
        return cell
    }
    
    // pagination
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = presenter.moviesList.count - 1
        if indexPath.row == lastItem {
            presenter.getMovies(isPagination: true)
        }
    }
}



// MARK: UIMenu

extension HomeViewController {
    private func createMenu(actionTitle: String? = nil) -> UIMenu {
        let menu = UIMenu(title: "Menu", children: [
            UIAction(title: SortMoviesEnum.popular.getValue().description) { [weak self] action in
                self?.rightBarButtonItem.menu = self?.createMenu(actionTitle: action.title)
                self?.presenter.changeSortingType(type: SortMoviesEnum.popular)
            },
            UIAction(title: SortMoviesEnum.unpopular.getValue().description) { [weak self] action in
                self?.rightBarButtonItem.menu = self?.createMenu(actionTitle: action.title)
                self?.presenter.changeSortingType(type: SortMoviesEnum.unpopular)
            },
     
        ])
        
        if let actionTitle = actionTitle {
            menu.children.forEach { action in
                guard let action = action as? UIAction else {
                    return
                }
                if action.title == actionTitle {
                    action.state = .on
                }
            }
        } else {
            let action = menu.children.first as? UIAction
            action?.state = .on
        }
        
        return menu
    }
}
