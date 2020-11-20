//
//  Locked.swift
//  Wordalysis
//
//  Created by Waleed Alassaf on 18/11/2020.
//  Copyright © 2020 Big Nerd Ranch. All rights reserved.
//

import Foundation

class Locked<Content> {
    private var content: Content
    private let semaphore = DispatchSemaphore(value: 1)
    
    init(_ content: Content) {
        self.content = content
    }
    
    func withLock<Return>(timeOut: DispatchTime = DispatchTime.now() + 10 , _ workItem: (inout Content) throws -> Return) rethrows -> Return? {
        
        let timeOutSemaphore = semaphore.wait(timeout: timeOut)
        
        guard timeOutSemaphore != .timedOut else {
            print("DEBUG: time out")
            return nil
        }
        defer { semaphore.signal() }
        
        let retVal = try workItem(&content)
        return retVal
    }
}
