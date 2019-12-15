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
        var testResult: String?
        let handler: (_ errorMessage: String?) -> Void = { errorMessage in
            testResult = errorMessage
        }
        // WHEN
        configureSut(fetchHandler: handler, userList: Mocked.userList, error: Mocked.error)
        sut.fetchUserList()

        // THEN
        XCTAssertNotNil(testResult)
    }

    func test_fetchUserList_errorHandler_message() {
        // GIVEN
        var testResult: String?
        let handler: (_ errorMessage: String?) -> Void = { errorMessage in
            testResult = errorMessage
        }

        // WHEN
        configureSut(fetchHandler: handler, userList: Mocked.userList, error: Mocked.error)
        sut.fetchUserList()

        // THEN
        XCTAssertEqual(testResult, Mocked.error.localizedDescription)
    }

    func test_fetchUserList_count() {
        // GIVEN
        var testResult: Int?
        let handler: (_ errorMessage: String?) -> Void = { errorMessage in
            testResult = self.sut.userCount()
        }

        // WHEN
        configureSut(fetchHandler: handler, userList: Mocked.userList)
        sut.fetchUserList()

        // THEN
        XCTAssertEqual(testResult, 2)
    }

    func test_fetchUserList_fetch_correctUser() {
        // GIVEN
        let expectedUser = Mocked.user
        let indexPath = IndexPath(row: 0, section: 0)
        var testResult: StackOverflowUser?
        let handler: (_ errorMessage: String?) -> Void = { errorMessage in
            testResult = self.sut.stackOverflowUserFor(indexPath)
        }

        // WHEN
        configureSut(fetchHandler: handler, userList: Mocked.userList)
        sut.fetchUserList()

        // THEN
        XCTAssertEqual(testResult, expectedUser)
    }

    func test_fetchUserList_userDetails() {
        // GIVEN
        let expectedUser = Mocked.user
        let indexPath = IndexPath(row: 0, section: 0)
        var testResult: StackOverflowUser?
        let handler: (_ errorMessage: String?) -> Void = { errorMessage in
            testResult = self.sut.stackOverflowUserFor(indexPath)
        }

        // WHEN
        configureSut(fetchHandler: handler, userList: Mocked.userList)
        sut.fetchUserList()

        // THEN
        XCTAssertEqual(testResult?.name, expectedUser.name)
        XCTAssertEqual(testResult?.profileImage, expectedUser.profileImage)
        XCTAssertEqual(testResult?.reputation, expectedUser.reputation)
    }

    // MARK: Private
    private enum Mocked {
        static let user = StackOverflowUser(name: "Ricardo Hurla", profileImage: nil, reputation: 1000)
        static let userList = StackOverflowUserList(users: [user, user], hasMore: false)
        static let error = RepositoryError.requestFailure
    }

    func configureSut(fetchHandler: @escaping (_ errorMessage: String?) -> Void,
                      userList: StackOverflowUserList,
                      error: Error? = nil) {
        let dataProvider = UserListDataProviderMocked(userList: userList, error: error)
        sut = UserListViewModel(dataProvider: dataProvider)
        sut.fetchHander = fetchHandler
    }
}
