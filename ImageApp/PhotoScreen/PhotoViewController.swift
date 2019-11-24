//
//  PhotoViewController.swift
//  ImageApp
//
//  Created by Stepan Chegrenev on 23.11.2019.
//  Copyright © 2019 Stepan Chegrenev. All rights reserved.
//

import UIKit

extension Notification.Name {
    static let photoWasViewed = Notification.Name("PhotoWasViewed")
    static let likeButtonDidTap = Notification.Name("LikeButtonDidTap")
}

class PhotoViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!

    var image: UIImage!
    var isLike: Bool!

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = image
        scrollView.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if !isLike {
            NotificationCenter.default.post(name: .photoWasViewed, object: nil)
        }
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        imageView
    }

    @IBAction func likeButtonAction(_ sender: Any) {
        NotificationCenter.default.post(name: .likeButtonDidTap, object: nil)
    }

    @IBAction func closeScreen(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
