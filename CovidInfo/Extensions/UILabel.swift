//
//  UILabel.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 09.02.2022.
//

import Foundation
import UIKit

extension UILabel{
    func initialize(text: String, color: UIColor, font: UIFont, alignment: NSTextAlignment, lines: Int){
        self.text = text
        self.textColor = color
        self.font = font
        self.textAlignment = alignment
        self.numberOfLines = lines
    }
}

func setNSMutableString(title: String, font: UIFont, foregroundColor: UIColor) -> NSMutableAttributedString{
    let title = NSMutableAttributedString(string: title, attributes: [
        NSMutableAttributedString.Key.font: font,
        NSMutableAttributedString.Key.foregroundColor: foregroundColor
    ])
    return title
}

