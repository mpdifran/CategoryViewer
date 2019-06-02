//
//  CategoryListViewModelImpl.swift
//  CategoryViewer
//
//  Created by Mark DiFranco on 2019-05-15.
//  Copyright © 2019 Mark DiFranco. All rights reserved.
//

import Foundation
import Swinject
import SwinjectAutoregistration

class CategoryListViewModelImpl {
    var categories = [CategoryCellViewModel]()

    fileprivate let categoryFetcher: CategoryFetcher

    init(categoryFetcher: CategoryFetcher) {
        self.categoryFetcher = categoryFetcher
    }
}

extension CategoryListViewModelImpl: CategoryViewControllerViewModel {

    func refreshCategories(completion: @escaping (Error?) -> Void) {
        categoryFetcher.fetchCategories { [weak self] (result) in
            switch result {
            case .success(let categories):
                self?.categories = categories.map({ CategoryViewModelImpl(category: $0) })
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
}

class CategoryListViewModelImplAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(CategoryViewControllerViewModel.self,
                               initializer: CategoryListViewModelImpl.init).inObjectScope(.transient)
    }
}
