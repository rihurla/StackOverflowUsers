//
//  StackOverflowUserStorage.swift
//  StackOverflowUsers
//
//  Created by Ricardo Hurla on 16/12/2019.
//  Copyright © 2019 Ricardo Hurla. All rights reserved.
//

import Foundation

public protocol StackOverflowUserStorageType {
    func storeUser(_ user: StackOverflowStorableUser)
    func deleteUser(_ user: StackOverflowStorableUser)
    func retrieveUser(_ user: StackOverflowUser) -> StackOverflowStorableUser?
}

public final class StackOverflowUserStorage: StackOverflowUserStorageType {

    // MARK: Private properties

    private let storage: UserDefaults
    private let encoder = PropertyListEncoder()
    private let decoder = PropertyListDecoder()
    private let storedUserListKey = "StackOverflowStoredUser"

    // MARK: Public methods

    init(storage: UserDefaults = UserDefaults.standard) {
        self.storage = storage
    }

    public func storeUser(_ user: StackOverflowStorableUser) {
        var storedUsers = retrieveStoredUsers()
        storedUsers.append(user)
        if let encodedStoredUsers = try? encoder.encode(storedUsers) {
            storage.set(encodedStoredUsers, forKey: storedUserListKey)
        }
    }

    public func deleteUser(_ user: StackOverflowStorableUser) {
        var storedUsers = retrieveStoredUsers()
        storedUsers.removeAll{$0.user == user.user}
        if let encodedStoredUsers = try? encoder.encode(storedUsers) {
            storage.set(encodedStoredUsers, forKey: storedUserListKey)
        }
    }

    public func retrieveUser(_ user: StackOverflowUser) -> StackOverflowStorableUser? {
        if let data = storage.value(forKey: storedUserListKey) as? Data,
            let storedUsers = try? decoder.decode(Array<StackOverflowStorableUser>.self, from: data),
            let user = storedUsers.first(where: {$0.user == user}) {
            return user
        }
        return nil
    }

    // MARK: Private methods

    private func retrieveStoredUsers() -> [StackOverflowStorableUser] {
        if let data = storage.value(forKey: storedUserListKey) as? Data,
            let storedUsers = try? decoder.decode(Array<StackOverflowStorableUser>.self, from: data) {
            return storedUsers
        }
        return []
    }
}
