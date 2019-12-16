//
//  UserListViewModel.swift
//  StackOverflowUsers
//
//  Created by Ricardo Hurla on 15/12/2019.
//  Copyright © 2019 Ricardo Hurla. All rights reserved.
//

import Foundation

protocol UserListViewModelType: UserCellViewModelDelegate {
    var fetchHander: ((_ errorMessage: String?) -> Void)? { get set }
    var updateHander: ((_ indexPath: IndexPath) -> Void)? { get set }
    func fetchUserList()
    func userCount() -> Int
    func stackOverflowUserFor(_ indexPath: IndexPath) -> StackOverflowUser
}

final class UserListViewModel: UserListViewModelType {

    // MARK: Public properties
    public var fetchHander: ((_ errorMessage: String?) -> Void)?
    public var updateHander: ((_ indexPath: IndexPath) -> Void)?

    // MARK: Private properties
    private let dataProvider: UserListDataProviderType
    private let userManager: StackOverflowUserManagerType
    private var userlist: [StackOverflowUser] = [] {
        didSet {
            fetchHander?(nil)
        }
    }

    // MARK: Public methods
    init(dataProvider: UserListDataProviderType = UserListDataProvider(),
         userManager: StackOverflowUserManagerType = StackOverflowUserManager()) {
        self.dataProvider = dataProvider
        self.userManager = userManager
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

// MARK: - Cell delegate
extension UserListViewModel: UserCellViewModelDelegate {
    func followUnfollowUser(_ user: StackOverflowUser) {
        guard let index = userlist.firstIndex(where: {$0 == user}) else { return }
        userManager.followUnfollowUser(user)
        updateHander?(IndexPath(row: index, section: 0))
    }

    func blockUnblockUser(_ user: StackOverflowUser) {
        guard let index = userlist.firstIndex(where: {$0 == user}) else { return }
        userManager.blockUnblockUser(user)
        updateHander?(IndexPath(row: index, section: 0))
    }
}
