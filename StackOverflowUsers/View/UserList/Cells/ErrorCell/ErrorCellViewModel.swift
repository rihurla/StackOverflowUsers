//
//  ErrorCellViewModel.swift
//  StackOverflowUsers
//
//  Created by Ricardo Hurla on 18/12/2019.
//  Copyright © 2019 Ricardo Hurla. All rights reserved.
//

import Foundation

protocol ErrorCellViewModelDelegate: AnyObject {
    func didTapRetry()
}

@objc protocol ErrorCellViewModelType {
    var errorTitle: String { get }
    var errorMessage: String { get }
    var retryButtonTitle: String { get }

    func didTapRetry()
}

final class ErrorCellViewModel: ErrorCellViewModelType {
    weak var delegate: ErrorCellViewModelDelegate?
    let errorTitle: String
    let errorMessage: String
    let retryButtonTitle: String

    init(errorMessage: String?) {
        self.errorMessage = errorMessage ?? NSLocalizedString("error_cell_default_message", comment: "")
        errorTitle = NSLocalizedString("error_cell_title", comment: "")
        retryButtonTitle = NSLocalizedString("error_cell_action_button_title", comment: "")
    }

    @objc func didTapRetry() {
        delegate?.didTapRetry()
    }
}
