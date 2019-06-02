//
//  CategoryFetcher.swift
//  CategoryViewer
//
//  Created by Mark DiFranco on 2019-05-13.
//  Copyright © 2019 Mark DiFranco. All rights reserved.
//

import Foundation
import Swinject
import SwinjectAutoregistration

protocol CategoryFetcher: class {
    func fetchCategories(completion: @escaping (Result<[Category], Error>) -> Void)
}

class CategoryFetcherImpl {
    enum RequestError: Error {
        case malformedURL
        case noData
    }

    fileprivate let categoryEndpoint = "" // TODO: Provide Endpoint

    fileprivate let jsonDecoder = JSONDecoder()

    fileprivate let urlSession: FaireURLSession
    fileprivate let dispatcher: Dispatcher

    init(urlSession: FaireURLSession, dispatcher: Dispatcher) {
        self.urlSession = urlSession
        self.dispatcher = dispatcher
    }
}

extension CategoryFetcherImpl: CategoryFetcher {

    func fetchCategories(completion: @escaping (Result<[Category], Error>) -> Void) {
        guard let url = URL(string: categoryEndpoint) else {
            completion(.failure(RequestError.malformedURL))
            return
        }

        let task = urlSession.dataTask(with: url) { [weak self] (data, response, error) in
            self?.dispatcher.async(queue: .main) {
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let data = data else {
                    completion(.failure(RequestError.noData))
                    return
                }

                do {
                    let categories = try self?.jsonDecoder.decode([Category].self, from: data) ?? []
                    completion(.success(categories))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}

class CategoryFetcherAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(CategoryFetcher.self, initializer: CategoryFetcherImpl.init).inObjectScope(.weak)
    }
}
