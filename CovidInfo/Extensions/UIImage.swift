//
//  UIImage.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 23.03.2022.
//

import Foundation
import UIKit

func imageViewRounded(image: UIImage) -> UIImageView{
    let imageView = UIImageView()
    imageView.image = image
    imageView.contentMode = .scaleAspectFit
    
    imageView.layer.cornerRadius = 29.5
    imageView.clipsToBounds = true
    imageView.layer.borderWidth = 5
    imageView.layer.borderColor = UIColor.lightGray.cgColor
    
    return imageView
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

