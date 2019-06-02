//
//  Dispatcher.swift
//  CategoryViewer
//
//  Created by Mark DiFranco on 2019-05-20.
//  Copyright © 2019 Mark DiFranco. All rights reserved.
//

import Foundation
import Swinject
import SwinjectAutoregistration

// MARK: - DispatcherQueueType

public enum DispatcherQueueType {
    case main
    case background
}

// MARK: - Dispatcher

public protocol Dispatcher: class {
    func sync(queue: DispatcherQueueType, execute block: () -> Void)
    func async(queue: DispatcherQueueType, execute block: @escaping () -> Void)
}

// MARK: - DispatcherImpl

class DispatcherImpl {
    fileprivate let backgroundQueue = DispatchQueue(label: "com.Faire.Dispatcher.backgroundQueue")
}

// MARK: Dispatcher Methods

extension DispatcherImpl: Dispatcher {

    func sync(queue: DispatcherQueueType, execute block: () -> Void) {
        retrieveQueue(for: queue).sync(execute: block)
    }

    func async(queue: DispatcherQueueType, execute block: @escaping () -> Void) {
        retrieveQueue(for: queue).async(execute: block)
    }
}

// MARK: Private Methods

private extension DispatcherImpl {

    func retrieveQueue(for queueType: DispatcherQueueType) -> DispatchQueue {
        switch queueType {
        case .main: return DispatchQueue.main
        case .background: return backgroundQueue
        }
    }
}

// MARK: - DispatcherAssembly

class DispatcherAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(Dispatcher.self,
                               initializer: DispatcherImpl.init).inObjectScope(.transient)
    }
}
