//
//  CategoryViewModelImpl.swift
//  CategoryViewer
//
//  Created by Mark DiFranco on 2019-05-15.
//  Copyright © 2019 Mark DiFranco. All rights reserved.
//

import Foundation

class CategoryViewModelImpl {
    fileprivate let category: Category

    init(category: Category) {
        self.category = category
    }
}

extension CategoryViewModelImpl: CategoryCellViewModel {

    var categoryName: String {
        return category.name
    }
}
