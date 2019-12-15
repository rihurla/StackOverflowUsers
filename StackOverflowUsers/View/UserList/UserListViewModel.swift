//
//  UserListViewModel.swift
//  StackOverflowUsers
//
//  Created by Ricardo Hurla on 15/12/2019.
//  Copyright © 2019 Ricardo Hurla. All rights reserved.
//

import Foundation

protocol UserListViewModelType {
    var fetchHander: ((_ errorMessage: String?) -> Void)? { get set }
    func fetchUserList()
    func userCount() -> Int
    func stackOverflowUserFor(_ indexPath: IndexPath) -> StackOverflowUser
}

final class UserListViewModel: UserListViewModelType {

    // MARK: Public properties
    public var fetchHander: ((_ errorMessage: String?) -> Void)?

    // MARK: Private properties
    private let dataProvider: UserListDataProviderType
    private var userlist: [StackOverflowUser] = [] {
        didSet {
            fetchHander?(nil)
        }
    }

    // MARK: Public methods
    init(dataProvider: UserListDataProviderType = UserListDataProvider()) {
        self.dataProvider = dataProvider
    }

    // MARK: Private methods
    private func onSuccess(userList: StackOverflowUserList) {
        self.userlist = userList.users
    }

    private func onFailure(error: Error?) {
        var errorMessage: String = RepositoryError.requestFailure.localizedDescription
        if let providedError = error {
            errorMessage = providedError.localizedDescription
        }
        fetchHander?(errorMessage)
    }
}

// MARK: - Request
extension UserListViewModel {
    public func fetchUserList() {
        dataProvider.fetchUserList(success: { [weak self] (users) in
            self?.onSuccess(userList: users)
        }, failure: { [weak self] (error) in
            self?.onFailure(error: error)
        })
    }
}

// MARK: - TableView provider
extension UserListViewModel {
    public func userCount() -> Int {
        return userlist.count
    }

    public func stackOverflowUserFor(_ indexPath: IndexPath) -> StackOverflowUser {
        return userlist[indexPath.item]
    }
}
