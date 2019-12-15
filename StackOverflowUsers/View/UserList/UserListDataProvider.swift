//
//  UserListDataProvider.swift
//  StackOverflowUsers
//
//  Created by Ricardo Hurla on 15/12/2019.
//  Copyright © 2019 Ricardo Hurla. All rights reserved.
//

import Foundation

protocol UserListDataProviderType {
    func fetchUserList(success: @escaping (StackOverflowUserList) -> Void,
                       failure: @escaping (Error?) -> Void)
}
public struct UserListDataProvider: UserListDataProviderType {

    // MARK: Private properties
    private let repository: StackOverflowRepositoryType
    private let parameters: RepositoryParameters = [
        "pagesize": "20",
        "order":"desc",
        "sort":"reputation",
        "site":"stackoverflow"
    ]

    // MARK: Public methods
    init(repository: StackOverflowRepositoryType = StackOverflowRepository()) {
        self.repository = repository
    }

    public func fetchUserList(success: @escaping (StackOverflowUserList) -> Void,
                              failure: @escaping (Error?) -> Void) {
        self.repository.fetchUserList(parameters: parameters, success: success, failure: failure)
    }
}
