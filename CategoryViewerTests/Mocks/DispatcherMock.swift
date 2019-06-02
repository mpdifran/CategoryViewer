//
//  DispatcherMock.swift
//  CategoryViewerTests
//
//  Created by Mark DiFranco on 2019-05-20.
//  Copyright © 2019 Mark DiFranco. All rights reserved.
//

import XCTest
@testable import CategoryViewer

// MARK: - DispatcherMock

class DispatcherMock: Dispatcher {
    fileprivate var mainBlocks = [() -> Void]()
    fileprivate var backgroundBlocks = [() -> Void]()

    func sync(queue: DispatcherQueueType, execute block: () -> Void) {
        block()
    }

    func async(queue: DispatcherQueueType, execute block: @escaping () -> Void) {
        switch queue {
        case .main: mainBlocks.append(block)
        case .background: backgroundBlocks.append(block)
        }
    }

    func executeNextBlock(for queue: DispatcherQueueType, numberOfBlocks: UInt = 1) {
        for _ in 0 ..< numberOfBlocks {
            let block: () -> Void
            switch queue {
            case .main:
                XCTAssertFalse(mainBlocks.isEmpty)
                block = mainBlocks.removeFirst()
            case .background:
                XCTAssertFalse(backgroundBlocks.isEmpty)
                block = backgroundBlocks.removeFirst()
            }
            block()
        }
    }

    func executeAllBlocks(for queue: DispatcherQueueType) {
        switch queue {
        case .main:
            mainBlocks.forEach { $0() }
            mainBlocks.removeAll()
        case .background:
            backgroundBlocks.forEach { $0() }
            backgroundBlocks.removeAll()
        }
    }
}
