//
//  RepositoryError.swift
//  StackOverflowUsers
//
//  Created by Ricardo Hurla on 15/12/2019.
//  Copyright © 2019 Ricardo Hurla. All rights reserved.
//

import Foundation

public enum RepositoryError: Error {
    case urlError
    case requestFailure
}

extension RepositoryError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .urlError, .requestFailure:
            return NSLocalizedString("repository_default_generic_error", comment: "default generic error")
        }
    }
}
