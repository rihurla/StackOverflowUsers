//
//  ButtonFactory.swift
//  StackOverflowUsers
//
//  Created by Ricardo Hurla on 16/12/2019.
//  Copyright © 2019 Ricardo Hurla. All rights reserved.
//

import UIKit

public struct ButtonFactory {
    public static func makeRoundedButton() -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = Sizing.button.height / 2
        button.layer.borderWidth = 1
        button.clipsToBounds = true
        button.titleLabel?.font = FontPallete.button
        return button
    }
}
