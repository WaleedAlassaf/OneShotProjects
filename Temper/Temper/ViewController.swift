//
//  Copyright (c) Big Nerd Ranch. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var celsiusField: UITextField!
    @IBOutlet weak var fahrenheitField: UITextField!
    
    let tempController = TempConverter()
    
    var tempFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        celsiusField.delegate = self
        fahrenheitField.delegate = self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // Get the user input as a Double
        let inputText = textField.text ?? ""
        guard let tempInput = Double(inputText) else {
            print("'\(inputText)' is not a number.")
            return false
        }
        
        // Convert the number and update the other field
        switch textField {
        case celsiusField:
            let tempOutput = tempController.convertToFahrenheight(tempInput)
            let formatterInput = NSNumber(value: tempOutput)
            let formatterOutput = tempFormatter.string(from: formatterInput)
            fahrenheitField.text = formatterOutput
        case fahrenheitField:
            let tempOutput = tempController.convertToCelsius(tempInput)
            let formatterInput = NSNumber(value: tempOutput)
            let formatterOutput = tempFormatter.string(from: formatterInput)
            celsiusField.text = formatterOutput
        default:
            fatalError("Input from unexpected text field \(textField)")
        }
        
        return false
    }

}

