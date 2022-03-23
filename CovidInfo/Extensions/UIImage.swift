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

