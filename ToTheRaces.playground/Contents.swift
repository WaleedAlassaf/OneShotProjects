import Cocoa
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let queue1 = DispatchQueue(label: "q1", qos: .utility)
let queue2 = DispatchQueue(label: "q2", qos: .userInitiated)
let group = DispatchGroup()
var balance = 0

private let semaphore = DispatchSemaphore(value: 1)


func lock(transfer: Int, withMessage message: String) {
    
    semaphore.wait()
    
    for _ in 1...5_000 {
        print(message)
        balance = balance + transfer
    }
    
    semaphore.signal()
}

group.enter()
queue1.async {

    lock(transfer: +1, withMessage: "Depositing $1")
    group.leave()

}
group.enter()
queue2.async {
    
    lock(transfer: -1, withMessage: "Withdrawing $1")
    group.leave()
}


group.notify(queue: .main) {
    print(balance)
}

