//
//  UIButton.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 31.01.2022.
//

import Foundation
import UIKit

func setNSMutableString(title: String, font: UIFont, foregroundColor: UIColor) -> NSMutableAttributedString{
    let title = NSMutableAttributedString(string: title, attributes: [
        NSMutableAttributedString.Key.font: font,
        NSMutableAttributedString.Key.foregroundColor: foregroundColor
    ])
    
    return title
}
