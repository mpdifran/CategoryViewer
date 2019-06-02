//
//  MainAssembler.swift
//  CategoryViewer
//
//  Created by Mark DiFranco on 2019-05-13.
//  Copyright © 2019 Mark DiFranco. All rights reserved.
//

import Foundation
import Swinject

class MainAssembler {
    var resolver: Resolver {
        return assembler.resolver
    }
    let assembler = Assembler()

    init() {
        Container.loggingFunction = nil

        assembler.apply(assembly: FaireURLSessionAssembly())
        assembler.apply(assembly: CategoryFetcherAssembly())
        assembler.apply(assembly: CategoryViewControllerAssembly())
        assembler.apply(assembly: CategoryListViewModelImplAssembly())
        assembler.apply(assembly: DispatcherAssembly())
    }
}
