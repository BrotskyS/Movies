//
//  ModuleBuilder.swift
//  Movies
//
//  Created by Sergiy Brotsky on 18.01.2023.
//

import Foundation
import UIKit

protocol AssemblyBuilderProtocol: AnyObject {
    func createHomeModule(router: RouterProtocol) -> UIViewController
    func createDetailMovie(movieId: Int, router: RouterProtocol) -> UIViewController
    func createImageViewer(image: UIImage?, router: RouterProtocol) -> UIViewController
}

class AssemblyBuilder: AssemblyBuilderProtocol {
    func createHomeModule(router: RouterProtocol) -> UIViewController {
        let view = HomeViewController()
        let networkService = NetworkService()
        let presenter = HomePresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        
        return view
    }
    
    func createDetailMovie(movieId: Int, router: RouterProtocol) -> UIViewController {
        
        let view = DetailMovieViewController()
        let networkService = NetworkService()
        let presenter = DetailMoviePresenter(view: view, networkService: networkService, router: router, movieId: movieId)
        view.presenter = presenter
        
        return view
    }
    
    func createImageViewer(image: UIImage?, router: RouterProtocol) -> UIViewController {
        let view = ImageViewerViewController()
        let presenter = ImageViewerPresenter(view: view, router: router, image: image)
        view.presenter = presenter
        
        return view
    }
    
}
