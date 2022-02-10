//
//  Triaj.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 05.02.2022.
//

import UIKit

class Triaj: XIB {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var label: UILabel!
    @IBOutlet var contentView: UIView!

    convenience init(image: String, labelText: String, labelColor: UIColor, isBigTitle: Bool, index: Int) {
        self.init()
        
        setup(image: image, labelText: labelText, labelColor: labelColor, isBigTitle: isBigTitle)
    }
    
    func setup(image: String, labelText: String, labelColor: UIColor, isBigTitle: Bool){
        self.imageView.image = UIImage.init(named: image)
        self.label.initialize(text: labelText, color: labelColor, font: UIFont(name: "IBMPlexSans-Bold", size: isBigTitle ? 20:30)!, alignment: .center, lines: 0)
    }
}
