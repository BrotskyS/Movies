//
//  ImageViewerPresenter.swift
//  Movies
//
//  Created by Sergiy Brotsky on 21.01.2023.
//

import Foundation
import UIKit

protocol ImageViewerViewProtocol: AnyObject {
    func updateImage(image: UIImage)
}

protocol ImageViewerPresenterProtocol: AnyObject {
    init(view: ImageViewerViewProtocol, router: RouterProtocol, image: UIImage?)
    
    var image: UIImage? {get set}
}

class ImageViewerPresenter: ImageViewerPresenterProtocol {
    
    weak var view: ImageViewerViewProtocol?
    var router: RouterProtocol?
    
    var image: UIImage?
    
    required init(view: ImageViewerViewProtocol, router: RouterProtocol, image: UIImage?) {
        self.view = view
        self.router = router
        self.image = image
    }
    
}
