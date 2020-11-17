//
//  ImageProcessingRequest.swift
//  Photorama
//
//  Created by Waleed Alassaf on 17/11/2020.
//  Copyright © 2020 Big Nerd Ranch. All rights reserved.
//

import Foundation

class ImageProcessingRequest {
    
    private var operation: ImageProcessingOperation
    private let queue: OperationQueue
    
    var priority: ImageProcessor.Priority = .low {
        
        didSet (oldPriority){
            guard priority != oldPriority else { return }
            guard !operation.isExecuting else { return }
            let newOp = ImageProcessingOperation(operation: operation, priority: priority)
            operation.cancel()
            operation = newOp
            queue.addOperation(newOp)
        
        }
    }
    
    init(operation: ImageProcessingOperation, queue: OperationQueue) {
        self.operation = operation
        self.queue = queue
    }
    
    func cancel() {
        operation.cancel()
    }
    
}
