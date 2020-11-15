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
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        let layer = imageView.layer
        let animation = CAKeyframeAnimation(keyPath: #keyPath(CALayer.transform))
        
        var perspective = CATransform3DIdentity
        perspective.m34 = -1.0/1000.0
        layer.transform = perspective
        
        let initial = layer.transform
        
        let angle = CGFloat.pi/2
        let rotateAround = CATransform3DRotate(initial, angle, 0.0, 1.0, 0.0)
        let rotateAndMoveLeft = CATransform3DTranslate(rotateAround, 0.0, 0.0, -100.0)
        let rotateAndMoveRight = CATransform3DTranslate(rotateAround, 0.0, 0.0, 100.0)
        animation.values = [
            initial, rotateAround, rotateAndMoveLeft, rotateAndMoveRight, initial
        ]
        
        animation.duration = 2.0
        layer.add(animation, forKey: "spin")
        layer.transform = rotateAround
        
        
        
        
//        // fade out animation
        
//        let animation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
//        animation.fromValue = NSNumber(value: 1.0)
//        animation.toValue = 0.0
//        animation.duration = 1.0
//        layer.add(animation, forKey: "disappear")
//        imageView.alpha = 0.0
        
        
        
//        if topPin.isActive {
//            imageHeight.constant = imageView.frame.height
//            imageHeight.isActive = true
//            topPin.isActive = false
//        }
//        let params = UISpringTimingParameters(mass: 0.5,
//                                              stiffness: 50.0,
//                                              damping: 1.0,
//                                              initialVelocity: CGVector.zero)
//
//        let animator = UIViewPropertyAnimator(duration: 1.0, timingParameters: params)
//        animator.addAnimations {
//
//            self.imageHeight.constant = 0.0
//            self.view.layoutIfNeeded()
//        }
//
////        let animator = UIViewPropertyAnimator(duration: 1.0, curve: .easeInOut) {
////            self.imageHeight.constant = -100
////            self.view.layoutIfNeeded()
////        }
//        animator.startAnimation()
        
        
        
    }
    
}
