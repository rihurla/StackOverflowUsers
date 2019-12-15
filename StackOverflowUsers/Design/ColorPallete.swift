//
//  ColorPallete.swift
//  StackOverflowUsers
//
//  Created by Ricardo Hurla on 15/12/2019.
//  Copyright © 2019 Ricardo Hurla. All rights reserved.
//
import UIKit

public enum ColorPalette {
    private enum DesignColor {
        static let textDark = "0x000000"
        static let textLight = "0x3d3d3d"
    }

    static let title = UIColor(hexString: DesignColor.textDark).withAlphaComponent(1)
    static let subtitle = UIColor(hexString: DesignColor.textLight).withAlphaComponent(1)
}

