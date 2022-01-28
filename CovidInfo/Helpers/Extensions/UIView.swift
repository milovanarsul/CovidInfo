//
//  UIView.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 27.01.2022.
//

import Foundation
import UIKit

extension UIView {

    @IBInspectable var dropShadow: Bool {
        set{
            if newValue {
                layer.shadowColor = UIColor.black.cgColor
                layer.shadowOpacity = 0.25
                layer.shadowRadius = 48
                layer.shadowOffset = CGSize.zero
                layer.cornerRadius = 24
            } else {
                layer.shadowColor = UIColor.clear.cgColor
                layer.shadowOpacity = 0
                layer.shadowRadius = 0
                layer.shadowOffset = CGSize.zero
                layer.cornerRadius = 24
            }
        }
        get {
            return layer.shadowOpacity > 0
        }
    }
    
    
    class func initFromNib<T: UIView>() -> T {
            return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?[0] as! T
    }
}
