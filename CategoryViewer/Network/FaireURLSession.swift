//
//  FaireURLSession.swift
//  CategoryViewer
//
//  Created by Mark DiFranco on 2019-05-13.
//  Copyright © 2019 Mark DiFranco. All rights reserved.
//

import Foundation
import Swinject

protocol FaireURLSession {

    func invalidateAndCancel()

    func dataTask(with url: URL,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> FaireURLSessionDataTask
}

extension URLSession: FaireURLSession {

    public func dataTask(with url: URL,
                         completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> FaireURLSessionDataTask {
        return dataTask(with: url, completionHandler: completionHandler) as URLSessionDataTask
    }
}

class FaireURLSessionAssembly: Assembly {

    func assemble(container: Container) {
        container.register(FaireURLSession.self, factory: { (_) in
            return URLSession.shared
        }).inObjectScope(.weak)
    }
}
