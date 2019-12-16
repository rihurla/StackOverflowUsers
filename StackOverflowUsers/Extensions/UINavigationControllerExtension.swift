//
//  UINavigationControllerExtension.swift
//  StackOverflowUsers
//
//  Created by Ricardo Hurla on 15/12/2019.
//  Copyright © 2019 Ricardo Hurla. All rights reserved.
//

import UIKit

extension UINavigationController {
    func configureAppearance() {
        navigationBar.isTranslucent = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationBar.prefersLargeTitles = true
    }
}
