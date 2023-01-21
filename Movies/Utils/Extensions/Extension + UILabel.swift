//
//  UILabel.swift
//  Movies
//
//  Created by Sergiy Brotsky on 19.01.2023.
//

import Foundation
import UIKit

extension UILabel {
    func setShadow() {
        layer.shadowColor = UIColor.white.cgColor
        layer.shadowRadius = 10
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.masksToBounds = false
    }
}
