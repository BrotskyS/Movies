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
    func createDetailMovie(id: String, router: RouterProtocol) -> UIViewController
}


class AssemblyBuilder: AssemblyBuilderProtocol {
    func createHomeModule(router: RouterProtocol) -> UIViewController {
        let view = HomeViewController()
        let networkService = NetworkService()
        let presenter = HomePresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        
        return view
    }
    
    func createDetailMovie(id: String, router: RouterProtocol) -> UIViewController {
        return UIViewController()
    }
    
    
}
