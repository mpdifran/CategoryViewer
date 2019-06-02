//
//  CategoryViewController.swift
//  CategoryViewer
//
//  Created by Mark DiFranco on 2019-05-13.
//  Copyright © 2019 Mark DiFranco. All rights reserved.
//

import UIKit
import Swinject

protocol CategoryViewControllerViewModel: class {
    var categories: [CategoryCellViewModel] { get }

    func refreshCategories(completion: @escaping (Error?) -> Void)
}

class CategoryViewController: UITableViewController {
    var viewModel: CategoryViewControllerViewModel!
}

extension CategoryViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        refreshCategories()
    }
}

private extension CategoryViewController {

    func refreshCategories() {
        viewModel.refreshCategories { [weak self] (error) in
            self?.tableView.reloadData()
            self?.refreshControl?.endRefreshing()

            guard let error = error else { return }

            self?.showErrorAlert(with: error)
        }
    }

    func showErrorAlert(with error: Error) {
        let alertController = UIAlertController(title: "Oopsie", message: error.localizedDescription, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)

        present(alertController, animated: true)
    }
}

extension CategoryViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell

        cell.viewModel = viewModel.categories[indexPath.row]

        return cell
    }
}

extension CategoryViewController {

    @IBAction func refreshCategories(_ sender: UIRefreshControl) {
        refreshCategories()
    }
}

class CategoryViewControllerAssembly: Assembly {

    func assemble(container: Container) {
        container.register(CategoryViewController.self) { (resolver) in
            let storyboard = UIStoryboard(name: "Category", bundle: nil)
            let viewController = storyboard.instantiateInitialViewController() as! CategoryViewController

            viewController.viewModel = resolver.resolve(CategoryViewControllerViewModel.self)

            return viewController
        }
    }
}
