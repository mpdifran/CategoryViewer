//
//  FaireURLSessionDataTask.swift
//  CategoryViewer
//
//  Created by Mark DiFranco on 2019-05-13.
//  Copyright © 2019 Mark DiFranco. All rights reserved.
//

import Foundation

public protocol FaireURLSessionTask {
    var taskIdentifier: Int { get }
    var response: URLResponse? { get }
    var error: Error? { get }

    func resume()
    func suspend()
    func cancel()
}

extension URLSessionTask: FaireURLSessionTask { }

public protocol FaireURLSessionDataTask: FaireURLSessionTask { }

extension URLSessionDataTask: FaireURLSessionDataTask { }
