//
//  FaireURLSessionMock.swift
//  CategoryViewerTests
//
//  Created by Mark DiFranco on 2019-05-15.
//  Copyright © 2019 Mark DiFranco. All rights reserved.
//

import Foundation
@testable import CategoryViewer

class FaireURLSessionMock: FaireURLSession {
    var didInvalidateAndCancel = false

    var lastURL: URL?
    var lastCompletionHandler: ((Data?, URLResponse?, Error?) -> Void)?
    var dataTaskToReturn = FaireURLSessionDataTaskMock()

    func invalidateAndCancel() {
        didInvalidateAndCancel = true
    }

    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> FaireURLSessionDataTask {
        lastURL = url
        lastCompletionHandler = completionHandler

        return dataTaskToReturn
    }
}
