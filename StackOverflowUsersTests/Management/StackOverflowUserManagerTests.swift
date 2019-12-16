//
//  StackOverflowUserManagerTests.swift
//  StackOverflowUsersTests
//
//  Created by Ricardo Hurla on 16/12/2019.
//  Copyright © 2019 Ricardo Hurla. All rights reserved.
//

import XCTest
@testable import StackOverflowUsers

class StackOverflowUserManagerTests: XCTestCase {

    var sut: StackOverflowUserManager!

    override func tearDown() {
        sut = nil
        storage = nil
        super.tearDown()
    }

    func test_followUser() {
        // GIVEN
        configureSut(user: Mocked.user)

        // WHEN
        sut.followUnfollowUser(Mocked.user)
        let retrievedUser = storage?.retrieveUser(Mocked.user)

        // THEN
        XCTAssertNotNil(retrievedUser)
        XCTAssertEqual(retrievedUser?.status, StackOverflowUserStatus.followed)
    }

    func test_followBlockedUser() {
        // GIVEN
        configureSut(user: Mocked.user)
        sut.blockUnblockUser(Mocked.user)

        // WHEN
        sut.followUnfollowUser(Mocked.user)
        let retrievedUser = storage?.retrieveUser(Mocked.user)

        // THEN
        XCTAssertNotNil(retrievedUser)
        XCTAssertEqual(retrievedUser?.status, StackOverflowUserStatus.followed)
    }

    func test_unfollowUser() {
        // GIVEN
        configureSut(storedUser: Mocked.followingUser)

        // WHEN
        sut.followUnfollowUser(Mocked.user)

        // THEN
        XCTAssertNil(storage?.retrieveUser(Mocked.user))
    }

    func test_blockUser() {
        // GIVEN
        configureSut(user: Mocked.user)

        // WHEN
        sut.blockUnblockUser(Mocked.user)
        let retrievedUser = storage?.retrieveUser(Mocked.user)

        // THEN
        XCTAssertNotNil(retrievedUser)
        XCTAssertEqual(retrievedUser?.status, StackOverflowUserStatus.blocked)
    }

    func test_blockFollowingUser() {
        // GIVEN
        configureSut(user: Mocked.user)
        sut.followUnfollowUser(Mocked.user)

        // WHEN
        sut.blockUnblockUser(Mocked.user)
        let retrievedUser = storage?.retrieveUser(Mocked.user)

        // THEN
        XCTAssertNotNil(retrievedUser)
        XCTAssertEqual(retrievedUser?.status, StackOverflowUserStatus.blocked)
    }

    func test_unblockUser() {
        // GIVEN
        configureSut(storedUser: Mocked.blockedUser)

        // WHEN
        sut.blockUnblockUser(Mocked.user)

        // THEN
        XCTAssertNil(storage?.retrieveUser(Mocked.user))
    }

    // MARK: Private

    private var storage: StackOverflowUserStorageMocked?

    private func configureSut(storedUser: StackOverflowStorableUser? = nil, user: StackOverflowUser? = nil) {
        let storage = StackOverflowUserStorageMocked(storedUser: storedUser, user: user)
        sut = StackOverflowUserManager(storage: storage)
        self.storage = storage
    }

    private enum Mocked {
        static let user = StackOverflowUser(accountId: 123, name: "Ricardo Hurla", profileImage: nil, reputation: 1000)
        static let cleanUser = StackOverflowStorableUser(user: user, status: .none)
        static let followingUser = StackOverflowStorableUser(user: user, status: .followed)
        static let blockedUser = StackOverflowStorableUser(user: user, status: .blocked)
    }

}
