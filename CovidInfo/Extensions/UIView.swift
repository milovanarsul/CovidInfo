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
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    func addSubView(parentView: UIView, childView: UIView){
        childView.frame = parentView.bounds
        childView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        parentView.addSubview(childView)
    }
    
    func fadeIn(duration: TimeInterval = 1.0) {
         UIView.animate(withDuration: duration, animations: {
            self.alpha = 1.0
         })
    }
    
    func fadeOut(duration: TimeInterval = 1.0) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.0
        })
    }
    
    func setShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowRadius = 5
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat){
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func findConstraint(layoutAttribute: NSLayoutConstraint.Attribute) -> NSLayoutConstraint? {
            if let constraints = superview?.constraints {
                for constraint in constraints where itemMatch(constraint: constraint, layoutAttribute: layoutAttribute) {
                    return constraint
                }
            }
            return nil
        }

    func itemMatch(constraint: NSLayoutConstraint, layoutAttribute: NSLayoutConstraint.Attribute) -> Bool {
        if let firstItem = constraint.firstItem as? UIView, let secondItem = constraint.secondItem as? UIView {
            let firstItemMatch = firstItem == self && constraint.firstAttribute == layoutAttribute
            let secondItemMatch = secondItem == self && constraint.secondAttribute == layoutAttribute
            return firstItemMatch || secondItemMatch
        }
        return false
    }
    
    func getConstraint(layoutAttribute: NSLayoutConstraint.Attribute) -> [NSLayoutConstraint]{
        return self.constraints.filter { $0.firstAttribute == layoutAttribute }
    }
    
    @discardableResult
    func addBlur(style: UIBlurEffect.Style) -> UIVisualEffectView {
        let blurEffect = UIBlurEffect(style: style)
        let blurBackground = UIVisualEffectView(effect: blurEffect)
        blurBackground.alpha = 0.7
        blurBackground.tag = 1
        addSubview(blurBackground)
        blurBackground.translatesAutoresizingMaskIntoConstraints = false
        blurBackground.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        blurBackground.topAnchor.constraint(equalTo: topAnchor).isActive = true
        blurBackground.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        blurBackground.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        return blurBackground
    }
    
    func removeBlur(){
        let blurBackground = viewWithTag(1)
        blurBackground?.removeFromSuperview()
    }
}
