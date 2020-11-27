// 
//  Copyright © 2019 Big Nerd Ranch
//

import UIKit

class PhotoInfoViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!

    var photo: Photo! {
        didSet {
            navigationItem.title = photo.title
        }
    }
    var store: PhotoStore!
    
    let viewsBox: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        return view
    }()
    
    let numberOfViews: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        store.fetchImage(for: photo) {
            (result) in
            switch result {
            case let .success(image):
                self.imageView.image = image
            case let .failure(error):
                print("Error fetching image for photo: \(error)")
            }
        }
        configureUI()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        photo.views += 1
    }

    //MARK:- Helpers
    
    func configureUI() {
        view.addSubview(viewsBox)
        viewsBox.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor,
                    right: view.safeAreaLayoutGuide.rightAnchor,
                    paddingBottom: 15, paddingRight: 15,
                    width: 90, height: 90)
        viewsBox.makeViewCircle(withWidth: 90)
        
        viewsBox.addSubview(numberOfViews)
        numberOfViews.text = "Views \(photo.views)"
        numberOfViews.center(inView: viewsBox)
        
        
    }
}
