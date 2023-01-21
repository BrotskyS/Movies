//
//  ImageViewerViewController.swift
//  Movies
//
//  Created by Sergiy Brotsky on 20.01.2023.
//

import UIKit



class ImageViewerViewController: UIViewController {

    
    private let scrollViewImage: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        
        return scrollView
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "TestImage1")
        image.contentMode = .scaleAspectFit
        
        
        return image
    }()
    
    var presenter: ImageViewerPresenterProtocol!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(scrollViewImage)
        
        scrollViewImage.addSubview(imageView)
        scrollViewImage.delegate = self
    
        
        setupConstraints()
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(tit
        
        imageView.image = presenter.image
    }
    
    
    
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollViewImage.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollViewImage.heightAnchor.constraint(equalTo: view.heightAnchor),
            
            imageView.widthAnchor.constraint(equalTo: scrollViewImage.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: scrollViewImage.heightAnchor)
        ])
    }
    

}


extension ImageViewerViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}


extension ImageViewerViewController: ImageViewerViewProtocol {
    func updateImage(image: UIImage) {
        imageView.image = image
    }
    
    
}
