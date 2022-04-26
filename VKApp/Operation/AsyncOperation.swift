//
//  AsyncOperation.swift
//  VKApp
//
//  Created by Никита Мошенцев on 13.04.2022.
//

import UIKit

class AsyncOperation: Operation {
    enum State: String {
        case ready, executing, finished
        var keyPath: String { return "is" + rawValue.capitalized }
    }
    
    var state = State.ready {
        willSet {
            willChangeValue(forKey: state.keyPath)
            willChangeValue(forKey: newValue.keyPath)
        }
        didSet {
            didChangeValue(forKey: state.keyPath)
            didChangeValue(forKey: oldValue.keyPath)
        }
    }

    override var isAsynchronous: Bool {
        true
    }
    
    override var isReady: Bool {
         super.isReady && state == .ready
    }
    
    override var isExecuting: Bool {
//        return super.isExecuting &&
        state == .executing
    }
    
    override var isFinished: Bool {
//        return super.isFinished &&
        state == .finished
    }
    
    override func start() {
        if isCancelled {
            state = .finished
        } else {
            main()
            state = .executing
        }
    }
    
    override func cancel() {
        super.cancel()
        state = .finished
    }
}
