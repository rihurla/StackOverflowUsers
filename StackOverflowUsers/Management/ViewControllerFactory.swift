//
//  ViewControllerFactory.swift
//  StackOverflowUsers
//
//  Created by Ricardo Hurla on 15/12/2019.
//  Copyright © 2019 Ricardo Hurla. All rights reserved.
//

import UIKit

public enum ViewControllerFactoryType {
    case userListViewController
}

public enum ViewControllerFactory {
    static func makeViewController(_ viewControllerType: ViewControllerFactoryType) -> UIViewController {
        switch viewControllerType {
        case .userListViewController:
            let viewModel = UserListViewModel()
            return UserListViewController(viewModel: viewModel)
        }
    }
}
