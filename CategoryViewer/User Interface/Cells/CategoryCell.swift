//
//  CategoryCell.swift
//  CategoryViewer
//
//  Created by Mark DiFranco on 2019-05-13.
//  Copyright © 2019 Mark DiFranco. All rights reserved.
//

import UIKit

protocol CategoryCellViewModel: class {
    var categoryName: String { get }
}

class CategoryCell: UITableViewCell {
    var viewModel: CategoryCellViewModel! {
        didSet {
            setupViewModel()
        }
    }

    @IBOutlet fileprivate var categoryLabel: UILabel!
}

extension CategoryCell {

    override func awakeFromNib() {
        super.awakeFromNib()

        prepareForReuse()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        categoryLabel.text = nil
    }
}

private extension CategoryCell {

    func setupViewModel() {
        categoryLabel.text = viewModel.categoryName
    }
}
