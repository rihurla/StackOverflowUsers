//
//  UserCellViewModelTests.swift
//  StackOverflowUsersTests
//
//  Created by Ricardo Hurla on 15/12/2019.
//  Copyright © 2019 Ricardo Hurla. All rights reserved.
//

import XCTest
@testable import StackOverflowUsers

class UserCellViewModelTests: XCTestCase {

    var sut: UserCellViewModel!

    override func setUp() {
        super.setUp()
        sut = UserCellViewModel(user: Mocked.user)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_userCell_userName() {
        // GIVEN
        let expectedName = Mocked.user.name

        // THEN
        XCTAssertEqual(sut.userName, expectedName)
    }

    func test_userCell_reputation() {
        // GIVEN
        let expectedReputation = "Reputation: \(Mocked.user.reputation)"

        // THEN
        XCTAssertEqual(sut.userReputation, expectedReputation)
    }

    func test_userCell_profileImage() {
        // GIVEN
        let expectedAvatar = Mocked.user.profileImage

        // THEN
        XCTAssertEqual(sut.userAvatar, expectedAvatar)
    }

    // MARK: Private
    private enum Mocked {
        static let user = StackOverflowUser(name: "Ricardo Hurla", profileImage: nil, reputation: 1000)
    }
    
}
