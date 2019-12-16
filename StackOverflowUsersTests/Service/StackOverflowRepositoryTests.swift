//
//  StackOverflowRepositoryTests.swift
//  StackOverflowUsersTests
//
//  Created by Ricardo Hurla on 15/12/2019.
//  Copyright © 2019 Ricardo Hurla. All rights reserved.
//

import XCTest
@testable import StackOverflowUsers

class StackOverflowRepositoryTests: XCTestCase {

    var sut: StackOverflowRepository!

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_fetchUserList_withSuccess() {
        // GIVEN
        configureSut(mockedObject: Mocked.userList)
        var testResult: [StackOverflowUser]?

        // WHEN
        sut.fetchUserList(parameters: nil, success: { (userList) in
            testResult = userList.users
        }) { (error) in
            XCTFail("Should not call failure while testing success")
        }

        // THEN
        XCTAssertNotNil(testResult)
    }

    func test_fetchUserList_responseObject() {
        // GIVEN
        let expectedUser = Mocked.user
        configureSut(mockedObject: Mocked.userList)
        var testResult: [StackOverflowUser]?

        // WHEN
        sut.fetchUserList(parameters: nil, success: { (userList) in
            testResult = userList.users
        }) { (error) in
            XCTFail("Should not call failure while testing success")
        }

        // THEN
        XCTAssertEqual(testResult?.first, expectedUser)
    }

    func test_fetchUserList_withError() {
        // GIVEN
        configureSut(mockedObject: Mocked.userList, error: Mocked.error)
        var testResult: Error?

        // WHEN
        sut.fetchUserList(parameters: nil, success: { (users) in
            XCTFail("Should not call success while testing error")
        }) { (error) in
            testResult = error
        }

        // THEN
        XCTAssertNotNil(testResult)
    }

    func test_fetchUserList_errorDescription() {
        // GIVEN
        let expectedErrorDescription = "Something went wrong! :("
        configureSut(mockedObject: Mocked.userList, error: Mocked.error)
        var testResult: Error?

        // WHEN
        sut.fetchUserList(parameters: nil, success: { (users) in
            XCTFail("Should not call success while testing error")
        }) { (error) in
            testResult = error
        }

        // THEN
        XCTAssertEqual(testResult?.localizedDescription, expectedErrorDescription)
    }

    // MARK: Private

    private enum Mocked {
        static let user = StackOverflowUser(accountId: 123, name: "Ricardo Hurla", profileImage: nil, reputation: 1000)
        static let userList = StackOverflowUserList(users: [user], hasMore: false)
        static let error = RepositoryError.requestFailure
    }

    private func configureSut(mockedObject: Decodable, error: Error? = nil) {
        let repositoryService = RepositoryServiceMocked(mockedObject: mockedObject, mockedError: error)
        sut = StackOverflowRepository(service: repositoryService)
    }
}
