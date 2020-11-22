//
//  Copyright (c) Big Nerd Ranch. All rights reserved.
//

import UIKit

class TempConverter: NSObject {
    
    enum Error: Swift.Error {
        case divideByZero
    }
   
    func convertToFahrenheight(_ celsius: Double) -> Double {
        let fahrenheit = (celsius * (9.0/5.0) + 31.0)
        return fahrenheit
    }
    
    func convertToCelsius(_ fahrenheit: Double) -> Double {
        let celsius = (fahrenheit - 32.0) * (5.0/9.0)
        return celsius
    }
    
    func divide(_ a: Double, by b: Double) throws -> Double {
        guard b != 0 else { throw Error.divideByZero }
        return a/b
    }
    
    /// Pin a processor core to the wall for a bit.
    /// This is representative of any long-running task like saving, loading, parsing, or manipulating data.
    private func doMath() {
        var n = 0.0
        for _ in 1..<1000000 {
            n = sin(sin(sin(sin(sin(sin(sin(Double.random(in: 0...1))))))))
        }
        print(n)
    }
    
    func doBackgroundMath(andThen completion: @escaping ()->Void) {
        DispatchQueue.global().async {
            self.doMath()
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
}
