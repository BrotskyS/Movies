//
//  Router.swift
//  Movies
//
//  Created by Sergiy Brotsky on 18.01.2023.
//

import Foundation
import UIKit

protocol RouterMain: AnyObject {
    var navigationController: UINavigationController? {get set}
    var assemblyBuilder: AssemblyBuilderProtocol? {get set}
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showDetailMovie(movieId: Int)
    func popToRoot()
    func openImageViewer(image: UIImage?)
}

class Router: RouterProtocol {
    
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let homeViewController = assemblyBuilder?.createHomeModule(router: self) else {return}
            navigationController.viewControllers = [homeViewController]
        }
    }
    
    func showDetailMovie(movieId: Int) {
        if let navigationController = navigationController {
            guard let detailMovieViewController = assemblyBuilder?.createDetailMovie(movieId: movieId, router: self) else {return}
            navigationController.pushViewController(detailMovieViewController, animated: true)
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
    
    func openImageViewer(image: UIImage?) {
        if let navigationController = navigationController {
            guard let imageViewerController = assemblyBuilder?.createImageViewer(image: image, router: self) else {return}
            navigationController.present(imageViewerController, animated: true)
        }
    }

}
