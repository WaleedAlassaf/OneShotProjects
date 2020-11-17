//
//  Copyright © 2015 Big Nerd Ranch
//

import UIKit

class PhotoInfoViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    var imageProcessor: ImageProcessor!
    var activeFilter: ImageProcessor.Filter!
    var request: ImageProcessingRequest?
    
    var photo: Photo! {
        didSet {
            navigationItem.title = photo.title
        }
    }
    var store: PhotoStore!
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        request?.cancel()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.fetchImage(for: photo, completion: { (result) -> Void in
            switch result {
                case let .success(image):
                    
                    let fuzzAction = ImageProcessor.Action.pixelateFaces
                    let filterAction = ImageProcessor.Action.filter(self.activeFilter)
                    let actions = [fuzzAction, filterAction]
                    
                    //                var filteredImage: UIImage
                    //                do {
                    //                    filteredImage = try self.imageProcessor.perform(actions, on: image)
                    //                } catch {
                    //                    print("Error: unable to filter image for \(String(describing: self.photo)): \(error)")
                    //                    filteredImage = image
                    //                }
                    
                    self.request = self.imageProcessor.process(image: image,
                                                               priority: .high,
                                                               actions: actions) { (actionResult) in
                        
                        let bigImage: UIImage
                        switch actionResult {
                            case let .success(filteredImage):
                                bigImage = filteredImage
                            case let .failure(error):
                                let photoID = self.photo.photoID ?? "<<unknown>>"
                                //                            print("Failed to process \(photoID) \(error)")
                                switch error {
                                    case ImageProcessor.Error.cancelled:
                                        print("Cancelled processing \(photoID)")
                                    default:
                                        print("Failed to process photo \(photoID) \(error)")
                                }
                                bigImage = image
                                
                        }
                        OperationQueue.main.addOperation {
                            self.imageView.image = bigImage
                        }
                    }
                    
                    
                    
                //                OperationQueue.main.addOperation {
                //                    self.imageView.image = filteredImage
                //                }
                case let .failure(error):
                    print("Error fetching image for photo: \(error)")
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            case "showTags"?:
                let navController = segue.destination as! UINavigationController
                let tagController = navController.topViewController as! TagsViewController
                
                tagController.store = store
                tagController.photo = photo
            default:
                preconditionFailure("Unexpected segue identifier.")
        }
    }
}
