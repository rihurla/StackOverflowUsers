//
//  RepositoryServiceMocked.swift
//  StackOverflowUsersTests
//
//  Created by Ricardo Hurla on 15/12/2019.
//  Copyright © 2019 Ricardo Hurla. All rights reserved.
//

import Foundation
@testable import StackOverflowUsers

public struct RepositoryServiceMocked: RepositoryServiceType {

    private let mockedObject: Decodable
    private let mockedError: Error?

    init(mockedObject: Decodable, mockedError: Error? = nil) {
        self.mockedObject = mockedObject
        self.mockedError = mockedError
    }

    public func makeRequest<T: Decodable>(url: URL?,
                                           success: @escaping (T) -> Void,
                                           failure: @escaping (Error?) -> Void) {
        if let error = self.mockedError {
            failure(error)
        } else {
            success(mockedObject as! T)
        }
    }
}
