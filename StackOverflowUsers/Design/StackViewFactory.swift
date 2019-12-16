//
//  StackViewFactory.swift
//  StackOverflowUsers
//
//  Created by Ricardo Hurla on 16/12/2019.
//  Copyright © 2019 Ricardo Hurla. All rights reserved.
//

import UIKit

public struct StackViewFactory {
    public static func makeLabelStackView(subViews: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: subViews)
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }

    public static func makeButtonsStackView(subViews: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: subViews)
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = Spacing.large
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }
}
