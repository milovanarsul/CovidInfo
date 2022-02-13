//
//  NSLayoutConstraint.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 29.01.2022.
//

import Foundation
import UIKit

extension NSLayoutConstraint {
    func changeMultiplier(multiplier: CGFloat) {
        let newConstraint = NSLayoutConstraint(item: firstItem as Any, attribute: firstAttribute, relatedBy: relation, toItem: secondItem, attribute: secondAttribute, multiplier: multiplier, constant: constant)
        newConstraint.priority = self.priority
        NSLayoutConstraint.deactivate([self])
        NSLayoutConstraint.activate([newConstraint])
    }
}
