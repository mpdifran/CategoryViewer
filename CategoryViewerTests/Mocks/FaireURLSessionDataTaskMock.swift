//
//  FaireURLSessionDataTaskMock.swift
//  CategoryViewerTests
//
//  Created by Mark DiFranco on 2019-05-15.
//  Copyright © 2019 Mark DiFranco. All rights reserved.
//

import Foundation
@testable import CategoryViewer

class FaireURLSessionDataTaskMock: FaireURLSessionDataTask {
    var taskIdentifier: Int = 1

    var response: URLResponse?

    var error: Error?

    var didResume = false
    var didSuspend = false
    var didCancel = false

    func resume() {
        didResume = true
    }

    func suspend() {
        didSuspend = true
    }

    func cancel() {
        didCancel = true
    }
}
