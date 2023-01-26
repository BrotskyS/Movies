//
//  Extension + String.swift
//  Movies
//
//  Created by Sergiy Brotsky on 21.01.2023.
//

import Foundation

extension String {
    func localised() -> String {
        NSLocalizedString(
            self,
            tableName: "Localizable",
            bundle: .main,
            value: self,
            comment: self
        )
    }
}
