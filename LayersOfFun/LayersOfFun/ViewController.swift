import UIKit
import QuartzCore

class ViewController: UIViewController {
    
    @IBOutlet var imageView: UIView!
    @IBOutlet var topPin: NSLayoutConstraint!
    @IBOutlet var imageHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.layer.cornerRadius = 20.0
        imageView.layer.masksToBounds = true
        
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.orange.cgColor
    }
    // MARK:- Challenge: Keyframe animation
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        
        let animator = UIViewPropertyAnimator(duration: 1.0, curve: .easeInOut) {
            
            UIView.animateKeyframes(withDuration: 2.0, delay: 0.0, options: [.calculationModeCubic]) {
                
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1) {
                    [self] in
                    if topPin.isActive {
                        imageHeight.constant = imageView.frame.height
                        imageHeight.isActive = true
                        topPin.isActive = false
                    }
                    UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .curveEaseInOut) {
                        
                        self.imageHeight.constant = 0.0
                        self.imageHeight.isActive = true
                        self.view.layoutIfNeeded()
                    }
                    
                }

            }
            
        }
        animator.startAnimation()
    }
}
