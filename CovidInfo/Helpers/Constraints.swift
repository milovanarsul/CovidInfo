//
//  NSLayoutConstraints.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 09.02.2022.
//

import Foundation
import UIKit

class Constraints{
    private var childView: UIView
    private var parentView: UIView
    private var secondView: UIView!
    private var constraints: [Constraint]
    
    init(childView: UIView, parentView: UIView, secondView: UIView? = nil, constraints: [Constraint]){
        self.childView = childView
        self.parentView = parentView
        self.constraints = constraints
        
        if let secondView = secondView {
            self.secondView = secondView
        }
    }
    
    func addConstraints(){
        var constraints = [NSLayoutConstraint]()
        
        self.childView.translatesAutoresizingMaskIntoConstraints = false
        
        for constraint in self.constraints{
            constraint.parentView = self.parentView
            constraint.childView = self.childView
            constraint.secondView = self.secondView
            
            constraints.append(constraint.setConstraint())
        }
        
        NSLayoutConstraint.activate(constraints)
    }
}

class Constraint{
    private var constraintType: ConstraintType
    var childView: UIView!
    var parentView: UIView!
    var secondView: UIView!
    private var multiplier: CGFloat
    private var constant: CGFloat
    
    init(constraintType: ConstraintType, multiplier: CGFloat, constant: CGFloat){
        self.constraintType = constraintType
        self.multiplier = multiplier
        self.constant = constant
    }
    
    init(childView: UIView, parentView: UIView, constraintType: ConstraintType, multiplier: CGFloat, constant: CGFloat){
        self.childView = childView
        self.parentView = parentView
        self.constraintType = constraintType
        self.multiplier = multiplier
        self.constant = constant
    }
    
    func setConstraint() -> NSLayoutConstraint{
        switch self.constraintType{
        case .width:
            return NSLayoutConstraint(item: self.childView!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: self.multiplier, constant: self.constant)
        case .height:
            return NSLayoutConstraint(item: self.childView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: self.multiplier, constant: self.constant)
        case .leading:
            return NSLayoutConstraint(item: self.childView!, attribute: .leading, relatedBy: .equal, toItem: self.parentView, attribute: .leading, multiplier: self.multiplier, constant: self.constant)
        case .trailing:
            return NSLayoutConstraint(item: self.childView!, attribute: .trailing, relatedBy: .equal, toItem: self.parentView, attribute: .trailing, multiplier: self.multiplier, constant: self.constant)
        case .top:
            return NSLayoutConstraint(item: self.childView!, attribute: .top, relatedBy: .equal, toItem: self.parentView, attribute: .top, multiplier: self.multiplier, constant: self.constant)
        case.bottom:
            return NSLayoutConstraint(item: self.parentView!, attribute: .bottom, relatedBy: .equal, toItem: self.childView, attribute: .bottom, multiplier: self.multiplier, constant: self.constant)
        case .bottomReverse:
            return NSLayoutConstraint(item: self.childView!, attribute: .bottom, relatedBy: .equal, toItem: self.parentView, attribute: .bottom, multiplier: self.multiplier, constant: self.constant)
        case .horizontal:
            return NSLayoutConstraint(item: self.childView!, attribute: .centerX, relatedBy: .equal, toItem: self.parentView, attribute: .centerX, multiplier: 1, constant: self.constant)
        case .vertical:
            return NSLayoutConstraint(item: self.childView!, attribute: .centerY, relatedBy: .equal, toItem: self.parentView, attribute: .centerY, multiplier: 1, constant: self.constant)
        case .aspectRatio:
            return NSLayoutConstraint(item: self.childView!, attribute: .height, relatedBy: .equal, toItem: self.childView, attribute: .width, multiplier: self.multiplier, constant: self.constant)
        case .proportionalHeight:
            return NSLayoutConstraint(item: self.childView!, attribute: .height, relatedBy: .equal, toItem: self.parentView, attribute: .height, multiplier: self.multiplier, constant: self.constant)
        case .proportionalWidth:
            return NSLayoutConstraint(item: self.childView!, attribute: .width, relatedBy: .equal, toItem: self.parentView, attribute: .width, multiplier: self.multiplier, constant: self.constant)
        case .verticalSpacing:
            return NSLayoutConstraint(item: self.childView!, attribute: .top, relatedBy: .equal, toItem: self.secondView, attribute: .bottom, multiplier: self.multiplier, constant: self.constant)
        case .horizontalSpacing:
            return NSLayoutConstraint(item: self.childView!, attribute: .leading, relatedBy: .equal, toItem: self.secondView, attribute: .trailing, multiplier: self.multiplier, constant: self.constant)
        }
    }
}

func defaultConstraints(childView: UIView, parentView: UIView){
    let constraints = Constraints(childView: childView, parentView: parentView, constraints: [
        Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
        Constraint(constraintType: .vertical, multiplier: 1, constant: 0),
        Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
        Constraint(constraintType: .proportionalHeight, multiplier: 1, constant: 0)
    ])
    constraints.addConstraints()
}

func defaultAnchors(childView: UIView, parentView: UIView){
    let constraints = Constraints(childView: childView, parentView: parentView, constraints: [
        Constraint(constraintType: .leading, multiplier: 1, constant: 0),
        Constraint(constraintType: .trailing, multiplier: 1, constant: 0),
        Constraint(constraintType: .top, multiplier: 1, constant: 0),
        Constraint(constraintType: .bottom, multiplier: 1, constant: 0)
    ])
    constraints.addConstraints()
}

func xyConstraints(childView: UIView, parentView: UIView){
    let constraints = Constraints(childView: childView, parentView: parentView, constraints: [
        Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
        Constraint(constraintType: .vertical, multiplier: 1, constant: 0)
    ])
    constraints.addConstraints()
}

func animateConstraints(constraints: [(constraint: NSLayoutConstraint, value: CGFloat, type: animateConstraintType)]){
    
    for constraint in constraints {
        switch constraint.type{
            case .multiplier:
            constraint.constraint.changeMultiplier(multiplier: constraint.value)
            case .constant:
            constraint.constraint.constant = constraint.value
        }
    }
}

extension NSLayoutConstraint {
    func changeMultiplier(multiplier: CGFloat) {
        NSLayoutConstraint.deactivate([self])
        let newConstraint = NSLayoutConstraint(item: firstItem as Any, attribute: firstAttribute, relatedBy: relation, toItem: secondItem, attribute: secondAttribute, multiplier: multiplier, constant: constant)
        newConstraint.priority = self.priority
        NSLayoutConstraint.activate([newConstraint])
    }
}
