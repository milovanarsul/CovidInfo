//
//  IncidenceCardPreview.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 13.04.2022.
//

import Foundation
import UIKit

class IncidenceCardPreview: UIView {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.initialize(text: "Incidenta cazurilor la nivel judetean in ultimele 14 zile", color: .black, font: boldFont(size: 18), alignment: .left, lines: 0)
        return label
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    func setup(){
        addSubviews(views: [titleLabel, containerView])
        
        let titleLabelConstraints = Constraints(childView: titleLabel, parentView: self, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 18),
            Constraint(constraintType: .top, multiplier: 1, constant: 15)
        ])
        titleLabelConstraints.addConstraints()
        
        let containerViewConstraints = Constraints(childView: containerView, parentView: self, constraints: [
            Constraint(constraintType: .proportionalWidth, multiplier: 0.9, constant: 0),
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 15)
        ])
        containerViewConstraints.addConstraints()
        NSLayoutConstraint.activate([NSLayoutConstraint(item: containerView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 15)])
    }
}
