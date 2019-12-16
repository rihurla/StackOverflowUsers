//
//  StackOverflowUserStorageMocked.swift
//  StackOverflowUsersTests
//
//  Created by Ricardo Hurla on 16/12/2019.
//  Copyright © 2019 Ricardo Hurla. All rights reserved.
//

import Foundation
@testable import StackOverflowUsers

final class StackOverflowUserStorageMocked: StackOverflowUserStorageType {

    private var storedUser: StackOverflowStorableUser?
    private var user: StackOverflowUser?

    init(storedUser: StackOverflowStorableUser?, user: StackOverflowUser?) {
        self.storedUser = storedUser
        self.user = user
    }

    func storeUser(_ user: StackOverflowStorableUser) {
        storedUser = user
    }

    func deleteUser(_ user: StackOverflowStorableUser) {
        storedUser = nil
    }

    func retrieveUser(_ user: StackOverflowUser) -> StackOverflowStorableUser? {
        return storedUser
    }
}
