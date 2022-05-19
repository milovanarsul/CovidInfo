//
//  Components.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 19.05.2022.
//

import Foundation
import UIKit

func componentView(tile: String, content: Double) -> UIView{
    let parentView = UIView()
    parentView.backgroundColor = .lightGray
    parentView.layer.cornerRadius = 20
    parentView.layer.masksToBounds = true
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.initialize(text: tile, color: .black, font: boldFont(size: 18), alignment: .left, lines: 0)
        return label
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.initialize(text: String(format: "%.0f", locale: Locale.current, content), color: .black, font: boldFont(size: 20), alignment: .left, lines: 0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    parentView.addSubviews(views: [titleLabel, contentLabel])
    
    let titleLabelConstraints = Constraints(childView: titleLabel, parentView: parentView, constraints: [
        Constraint(constraintType: .leading, multiplier: 1, constant: 10),
        Constraint(constraintType: .top, multiplier: 1, constant: 10),
        Constraint(constraintType: .proportionalWidth, multiplier: 0.9, constant: 0)
    ])
    titleLabelConstraints.addConstraints()
    
    contentLabel.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 10).isActive = true
    contentLabel.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -10).isActive = true
    
    return parentView
}

func componentHorizontalStack(view1: UIView, view2: UIView) -> UIStackView{
    let stackView = UIStackView()
    stackView.initalize(axis: .horizontal, alignment: .fill, distribution: .fillEqually, spacing: 10)
    stackView.addAranagedSubviews(views: [view1, view2])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.heightAnchor.constraint(equalToConstant: 120).isActive = true
    return stackView
}

func componentVerticalStackView(stackViews: [(UIView, UIView)]) -> UIStackView{
    let stackView = UIStackView()
    stackView.initalize(axis: .vertical, alignment: .fill, distribution: .fill, spacing: 10)
    
    for view in stackViews{
        let horizontalStackView = componentHorizontalStack(view1: view.0, view2: view.1)
        stackView.addArrangedSubview(horizontalStackView)
    }
    
    return stackView
}
