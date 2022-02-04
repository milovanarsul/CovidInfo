//
//  UIButton.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 31.01.2022.
//

import Foundation
import UIKit

func changeButtonTitle(title: String, font: String, fontSize: CGFloat, color: UIColor) -> NSMutableAttributedString{
    
    let newTitle = NSMutableAttributedString(string: title, attributes: [
     NSMutableAttributedString.Key.font: UIFont(name: font, size: fontSize) as Any,
     NSMutableAttributedString.Key.foregroundColor: color
 ])
    
    return newTitle
}
