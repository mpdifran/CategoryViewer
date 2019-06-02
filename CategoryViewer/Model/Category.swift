//
//  Category.swift
//  CategoryViewer
//
//  Created by Mark DiFranco on 2019-05-13.
//  Copyright © 2019 Mark DiFranco. All rights reserved.
//

import Foundation

struct Category: Codable {
    let name: String
}

extension Category: Equatable {

    static func == (lhs: Category, rhs: Category) -> Bool {
        return lhs.name == rhs.name
    }
}
