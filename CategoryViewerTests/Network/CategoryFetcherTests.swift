//
//  CategoryFetcherTests.swift
//  CategoryViewerTests
//
//  Created by Mark DiFranco on 2019-05-15.
//  Copyright © 2019 Mark DiFranco. All rights reserved.
//

import XCTest
@testable import CategoryViewer

class CategoryFetcherTests: XCTestCase {

    var sut: CategoryFetcher!

    var urlSessionMock: FaireURLSessionMock!
    var dispatcherMock: DispatcherMock!

    // MARK: - SetUp / TearDown

    override func setUp() {
        super.setUp()

        urlSessionMock = FaireURLSessionMock()
        dispatcherMock = DispatcherMock()

        sut = CategoryFetcherImpl(urlSession: urlSessionMock, dispatcher: dispatcherMock)
    }

    // MARK: - Test Methods

    func test_fetchCategories_responseIsError_errorPassedToCompletion() {
        // Arrange
        let expectedError = NSError(domain: "Test", code: 1, userInfo: nil)
        let exp = expectation(description: "\(#function)")

        // Act
        sut.fetchCategories { (result) in
            exp.fulfill()
            switch result {
            case .failure(let error):
                XCTAssertEqual(expectedError, error as NSError?)
            default:
                XCTFail("Result should not have been a success")
            }
        }
        urlSessionMock.lastCompletionHandler?(nil, nil, expectedError)
        dispatcherMock.executeNextBlock(for: .main)

        // Assert
        waitForExpectations(timeout: 1)
    }

    func test_fetchCategories_responseIsCategoryData_categoriesPassedToCompletion() {
        // Arrange
        let jsonData = "[{\"name\":\"First\"},{\"name\":\"Second\"}]".data(using: .utf8)
        let expectedCategories = [Category(name: "First"), Category(name: "Second")]
        let exp = expectation(description: "\(#function)")

        // Act
        sut.fetchCategories { (result) in
            exp.fulfill()
            switch result {
            case .success(let categories):
                XCTAssertEqual(expectedCategories, categories)
            default:
                XCTFail("Result should not have been a failure")
            }
        }
        urlSessionMock.lastCompletionHandler?(jsonData, nil, nil)
        dispatcherMock.executeNextBlock(for: .main)

        // Assert
        waitForExpectations(timeout: 1)
    }
}
