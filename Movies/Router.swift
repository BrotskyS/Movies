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
    func showDetailMovie(id: String)
    func popToRoot()
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
    
    func showDetailMovie(id: String) {
        if let navigationController = navigationController {
            guard let DetailMovieViewController = assemblyBuilder?.createDetailMovie(id: id, router: self) else {return}
            navigationController.pushViewController(DetailMovieViewController, animated: true)
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
    
    
    
    
}
