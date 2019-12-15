//
//  UserListDataProviderMocked.swift
//  StackOverflowUsersTests
//
//  Created by Ricardo Hurla on 15/12/2019.
//  Copyright © 2019 Ricardo Hurla. All rights reserved.
//

import Foundation
@testable import StackOverflowUsers

public final class UserListDataProviderMocked: UserListDataProviderType {

    private let userList: StackOverflowUserList
    private let error: Error?

    init(userList: StackOverflowUserList, error: Error?) {
        self.userList = userList
        self.error = error
    }

    public func fetchUserList(success: @escaping (StackOverflowUserList) -> Void,
                              failure: @escaping (Error?) -> Void) {
        if let fetchError = self.error {
            failure(fetchError)
        } else {
            success(userList)
        }
    }
}
