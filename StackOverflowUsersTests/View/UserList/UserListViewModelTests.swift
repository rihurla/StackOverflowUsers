//
//  UserListViewModelTests.swift
//  StackOverflowUsersTests
//
//  Created by Ricardo Hurla on 15/12/2019.
//  Copyright © 2019 Ricardo Hurla. All rights reserved.
//

import XCTest
@testable import StackOverflowUsers

class UserListViewModelTests: XCTestCase {

    var sut: UserListViewModel!

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_fetchUserList_errorHandler() {
        // GIVEN
        var testResult: Bool = true
        let handler: (_ success: Bool) -> Void = { success in
            testResult = success
        }
        configureSut(fetchHandler: handler, userList: Mocked.userList, error: Mocked.error)

        // WHEN
        sut.fetchUserList()

        // THEN
        XCTAssertFalse(testResult)
    }

    func test_fetchUserList_errorHandler_message() {
        // GIVEN
        let handler: (_ success: Bool) -> Void = { success in }
        configureSut(fetchHandler: handler, userList: Mocked.userList, error: Mocked.error)

        // WHEN
        sut.fetchUserList()

        // THEN
        XCTAssertEqual(sut.errorMessage, Mocked.error.localizedDescription)
    }

    func test_fetchUserList_count() {
        // GIVEN
        var testResult: Int?
        let handler: (_ success: Bool) -> Void = { success in
            testResult = self.sut.userCount()
        }
        configureSut(fetchHandler: handler, userList: Mocked.userList)

        // WHEN
        sut.fetchUserList()

        // THEN
        XCTAssertEqual(testResult, 2)
    }

    func test_fetchUserList_fetch_correctUser() {
        // GIVEN
        let expectedUser = Mocked.user
        let indexPath = IndexPath(row: 0, section: 0)
        var testResult: StackOverflowUser?
        let handler: (_ success: Bool) -> Void = { success in
            testResult = self.sut.stackOverflowUserFor(indexPath)
        }
        configureSut(fetchHandler: handler, userList: Mocked.userList)

        // WHEN
        sut.fetchUserList()

        // THEN
        XCTAssertEqual(testResult, expectedUser)
    }

    func test_fetchUserList_userDetails() {
        // GIVEN
        let expectedUser = Mocked.user
        let indexPath = IndexPath(row: 0, section: 0)
        var testResult: StackOverflowUser?
        let handler: (_ success: Bool) -> Void = { success in
            testResult = self.sut.stackOverflowUserFor(indexPath)
        }
        configureSut(fetchHandler: handler, userList: Mocked.userList)

        // WHEN
        sut.fetchUserList()

        // THEN
        XCTAssertEqual(testResult?.name, expectedUser.name)
        XCTAssertEqual(testResult?.profileImage, expectedUser.profileImage)
        XCTAssertEqual(testResult?.reputation, expectedUser.reputation)
    }

    func test_followUser_updateHandler() {
        // GIVEN
        var testResult: IndexPath?
        let handler: (_ indexPath: IndexPath) -> Void = { indexPath in
            testResult = indexPath
        }
        configureSut(updateHandler: handler, userList: Mocked.userList)
        sut.fetchUserList()

        // WHEN
        sut.followUnfollowUser(Mocked.userList.users[0])

        XCTAssertEqual(testResult, IndexPath(item: 0, section: 0))
    }

    func test_block_updateHandler() {
        // GIVEN
        var testResult: IndexPath?
        let handler: (_ indexPath: IndexPath) -> Void = { indexPath in
            testResult = indexPath
        }
        configureSut(updateHandler: handler, userList: Mocked.userList)
        sut.fetchUserList()

        // WHEN
        sut.blockUnblockUser(Mocked.userList.users[0])

        XCTAssertEqual(testResult, IndexPath(item: 0, section: 0))
    }

    // MARK: Private
    private enum Mocked {
        static let user = StackOverflowUser(accountId: 123, name: "Ricardo Hurla", profileImage: nil, reputation: 1000)
        static let userList = StackOverflowUserList(users: [user, user], hasMore: false)
        static let error = RepositoryError.requestFailure
    }

    func configureSut(fetchHandler: @escaping (_ success: Bool) -> Void = {_ in },
                      updateHandler: @escaping (_ indexPath: IndexPath) -> Void = {_ in },
                      userList: StackOverflowUserList,
                      error: Error? = nil) {
        let dataProvider = UserListDataProviderMocked(userList: userList, error: error)
        sut = UserListViewModel(dataProvider: dataProvider, userManager: StackOverflowUserManagerMocked())
        sut.fetchHander = fetchHandler
        sut.updateHander = updateHandler
    }
}
