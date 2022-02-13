//
//  UIStackView.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 13.02.2022.
//

import Foundation
import UIKit

extension UIStackView{
    func initalize(axis: NSLayoutConstraint.Axis, alignment: UIStackView.Alignment, distribution: UIStackView.Distribution, spacing: CGFloat){
        self.axis = axis
        self.alignment = alignment
        self.distribution = distribution
        self.spacing = spacing
    }
}
