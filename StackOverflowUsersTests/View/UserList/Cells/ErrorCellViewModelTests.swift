//
//  ErrorCellViewModelTests.swift
//  StackOverflowUsersTests
//
//  Created by Ricardo Hurla on 18/12/2019.
//  Copyright © 2019 Ricardo Hurla. All rights reserved.
//

import XCTest
@testable import StackOverflowUsers

class ErrorCellViewModelTests: XCTestCase {

    var sut: ErrorCellViewModel!

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_errorCell_title() {
        // GIVEN
        configureSut()

        // THEN
        XCTAssertEqual(sut.errorTitle, "Something went wrong :(")
    }

    func test_errorCell_defaultMessage() {
        // GIVEN
        configureSut()

        // THEN
        XCTAssertEqual(sut.errorMessage, Mocked.error.localizedDescription)
    }

    func test_errorCell_customMessage() {
        // GIVEN
        let customMsg = "Test error :("
        configureSut(errorMsg: customMsg)

        // THEN
        XCTAssertEqual(sut.errorMessage, customMsg)
    }

    func test_errorCell_buttonTitle() {
        // GIVEN
        configureSut()

        // THEN
        XCTAssertEqual(sut.retryButtonTitle, "Retry")
    }

    // MARK: Private
    private enum Mocked {
        static let error = RepositoryError.requestFailure
    }

    private func configureSut(errorMsg: String? = nil) {
        sut = ErrorCellViewModel(errorMessage: errorMsg)
    }
}
