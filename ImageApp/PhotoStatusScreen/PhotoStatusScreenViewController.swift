//
//  PhotoStatusScreenViewController.swift
//  ImageApp
//
//  Created by Stepan Chegrenev on 21.11.2019.
//  Copyright © 2019 Stepan Chegrenev. All rights reserved.
//

import UIKit

class PhotoStatusScreenViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var image: UIImage!
    @IBOutlet weak var photoStatus: UILabel!
    var isLike: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = image

        NotificationCenter.default.addObserver(self, selector: #selector(likeButtonDidTap), name: .likeButtonDidTap, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(photoWasViewed), name: .photoWasViewed, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func likeButtonDidTap() {
        isLike = true
        photoStatus.text = "Понравилось"
    }

    @objc func photoWasViewed() {
        photoStatus.text = "Просмотрено"
    }
    
    @IBAction func openPhotoScreen(_ sender: Any) {
        let photoViewController = UIStoryboard(name: "PhotoScreen", bundle: nil).instantiateViewController(withIdentifier: String(describing: PhotoViewController.self)) as! PhotoViewController

        photoViewController.image = image
        photoViewController.isLike = isLike

        if #available(iOS 13.0, *) {
            photoViewController.isModalInPresentation = true
            photoViewController.modalPresentationStyle = .fullScreen
        }
        self.present(photoViewController, animated: true, completion: nil)
    }
}
