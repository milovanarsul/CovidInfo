//
//  BlurShadowView.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 12.01.2022.
//

import UIKit

@IBDesignable
class BlurShadowView: UIView {
    @IBInspectable var shadowOpacity: Float = 0 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }

    @IBInspectable var shadowRadius: CGFloat = 0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }

    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0.0, height: 0.0) {
        didSet {
            layer.shadowOffset = shadowOffset
        }
    }

    @IBInspectable var shadowColor: UIColor? = UIColor(red: 157/255, green: 157/255, blue: 157/255, alpha: 1.0) {
        didSet {
            layer.shadowColor = shadowColor?.cgColor
        }
    }
}
