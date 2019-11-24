//
//  ImageDownloader.swift
//  ImageApp
//
//  Created by Stepan Chegrenev on 20.11.2019.
//  Copyright © 2019 Stepan Chegrenev. All rights reserved.
//

import UIKit

class ImageDownloader {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit, callback: @escaping (UIImage) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200, let mimeType = response?.mimeType, mimeType.hasPrefix("image"), let data = data, error == nil, let image = UIImage(data: data) else { return }

                callback(image)
        }.resume()
    }

    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit, callback: @escaping (UIImage) -> Void) {
        guard let url = URL(string: link) else { return }
        self.downloaded(from: url, contentMode: mode, callback: { image in
            callback(image)
        })
    }
}
