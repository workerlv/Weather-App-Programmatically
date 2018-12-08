//
//  viewExtensions.swift
//  WatherApp
//
//  Created by Arturs Vitins on 08/12/2018.
//  Copyright © 2018 Arturs Vitins. All rights reserved.
//

import UIKit

extension UIView {
    func attachZeroAnchors(to view: UIView, with insets: UIEdgeInsets = .zero) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -insets.right),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left)
            ])
    }
}
