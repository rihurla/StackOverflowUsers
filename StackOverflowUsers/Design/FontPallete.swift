//
//  FontPallete.swift
//  StackOverflowUsers
//
//  Created by Ricardo Hurla on 15/12/2019.
//  Copyright © 2019 Ricardo Hurla. All rights reserved.
//

import UIKit

public enum FontPallete {
    private enum FontSize {
        static let large: CGFloat = 18
        static let regular: CGFloat = 14
    }

    static let title = UIFont.boldSystemFont(ofSize: FontSize.large)
    static let subtitle = UIFont.systemFont(ofSize: FontSize.regular)
}
