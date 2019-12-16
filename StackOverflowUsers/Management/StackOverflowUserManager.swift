//
//  StackOverflowUserManager.swift
//  StackOverflowUsers
//
//  Created by Ricardo Hurla on 16/12/2019.
//  Copyright © 2019 Ricardo Hurla. All rights reserved.
//

import Foundation

protocol StackOverflowUserManagerType {
    func followUnfollowUser(_ user: StackOverflowUser)
    func blockUnblockUser(_ user: StackOverflowUser)
}

final class StackOverflowUserManager: StackOverflowUserManagerType {
    let storage: StackOverflowUserStorageType

    init(storage: StackOverflowUserStorageType = StackOverflowUserStorage()) {
        self.storage = storage
    }

    func followUnfollowUser(_ user: StackOverflowUser) {
        if let storedUser = storage.retrieveUser(user) {
            switch storedUser.status {
            case .blocked:
                storage.deleteUser(storedUser)
                storage.storeUser(StackOverflowStorableUser(user: user, status: .followed))
            case .followed:
                storage.deleteUser(storedUser)
            case .none:
                return
            }
        } else {
            storage.storeUser(StackOverflowStorableUser(user: user, status: .followed))
        }
    }

    func blockUnblockUser(_ user: StackOverflowUser) {
        if let storedUser = storage.retrieveUser(user) {
            switch storedUser.status {
            case .blocked:
                storage.deleteUser(storedUser)
            case .followed:
                storage.deleteUser(storedUser)
                storage.storeUser(StackOverflowStorableUser(user: user, status: .blocked))
            case .none:
                return
            }
        } else {
            storage.storeUser(StackOverflowStorableUser(user: user, status: .blocked))
        }
    }
}
