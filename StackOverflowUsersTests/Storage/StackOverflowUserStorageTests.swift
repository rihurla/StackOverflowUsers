//
//  StackOverflowUserStorageTests.swift
//  StackOverflowUsersTests
//
//  Created by Ricardo Hurla on 16/12/2019.
//  Copyright © 2019 Ricardo Hurla. All rights reserved.
//

import XCTest
@testable import StackOverflowUsers

class StackOverflowUserStorageTests: XCTestCase {

    var sut: StackOverflowUserStorage!
    
    override func setUp() {
        super.setUp()
        sut = StackOverflowUserStorage(storage: UserDefaultsMocked())
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_storeUser() {
        // WHEN
        sut.storeUser(Mocked.followingUser)

        // THEN
        XCTAssertNotNil(sut.retrieveUser(Mocked.user))
    }

    func test_deleteUser() {
        // GIVEN
        sut.storeUser(Mocked.followingUser)

        // WHEN
        sut.deleteUser(Mocked.followingUser)

        // THEN
        XCTAssertNil(sut.retrieveUser(Mocked.user))
    }

    func test_retrieveUser_object() {
        // GIVEN
        sut.storeUser(Mocked.followingUser)

        // WHEN
        let retrievedUser = sut.retrieveUser(Mocked.user)

        // THEN
        XCTAssertEqual(retrievedUser?.user, Mocked.user)
    }

    func test_retrieveUser_status() {
        // GIVEN
        sut.storeUser(Mocked.followingUser)

        // WHEN
        let retrievedUser = sut.retrieveUser(Mocked.user)

        // THEN
        XCTAssertEqual(retrievedUser?.status, Mocked.status)
    }

    func test_retrieveUser_without_storedUsers() {
        // WHEN
        let retrievedUser = sut.retrieveUser(Mocked.user)

        // THEN
        XCTAssertNil(retrievedUser)
    }

    // MARK: Private

    private enum Mocked {
        static let status = StackOverflowUserStatus.followed
        static let user = StackOverflowUser(accountId: 123, name: "Ricardo Hurla", profileImage: nil, reputation: 1000)
        static let followingUser = StackOverflowStorableUser(user: user, status: .followed)
    }
}
