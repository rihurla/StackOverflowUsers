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
        self.navigationBar.isTranslucent = true
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationBar.prefersLargeTitles = true
    }
}
