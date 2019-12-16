//
//  ColorPallete.swift
//  StackOverflowUsers
//
//  Created by Ricardo Hurla on 15/12/2019.
//  Copyright © 2019 Ricardo Hurla. All rights reserved.
//

import UIKit

public enum ColorPalette {
    static var text: UIColor {
        return UIColor(named: "text") ?? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    static var greenActive: UIColor {
        return  UIColor(named: "greenActive") ?? #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
    }
    static var redActive: UIColor {
        return UIColor(named: "redActive") ?? #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
    }
}
