//
//  GenericViews.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 18.05.2022.
//

import Foundation
import UIKit

func iconText(icon: String, text: String, system: Bool, textColor: UIColor, fontSize: CGFloat? = nil) -> UIView{
    lazy var icon: UIImageView = {
        let imageView = UIImageView()
        
        switch system{
        case true:
            imageView.image = UIImage(systemName: icon)
        case false:
            imageView.image = UIImage(named: icon)
        }

        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        return imageView
    }()
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.initialize(text: text, color: textColor, font: UIFont(name: "IBMPlexSans-Regular", size: fontSize ?? 12)!, alignment: .left, lines: 0)
        return label
    }()
    
    let contentView = UIView()
    contentView.backgroundColor = .clear
    contentView.addSubviews(views: [icon, textLabel])
    
    let iconConstraints = Constraints(childView: icon, parentView: contentView, constraints: [
        Constraint(constraintType: .leading, multiplier: 1, constant: -5),
        Constraint(constraintType: .proportionalWidth, multiplier: 0.15, constant: 0),
        Constraint(constraintType: .vertical, multiplier: 1, constant: 0),
        Constraint(constraintType: .proportionalHeight, multiplier: 1, constant: 0)
    ])
    iconConstraints.addConstraints()
    
    let textLabelConstraints = Constraints(childView: textLabel, parentView: contentView, constraints: [
        Constraint(constraintType: .vertical, multiplier: 1, constant: 0)
    ])
    textLabelConstraints.addConstraints()
    NSLayoutConstraint.activate([textLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 12)])
    
    return contentView
}

func iconTextData(icon: String, text: String, data: String) -> UIView{
    lazy var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: icon)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        return imageView
    }()
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.initialize(text: text, color: .black, font: UIFont(name: "IBMPlexSans-Regular", size: 12)!, alignment: .left, lines: 0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var dataLabel: UILabel = {
        let label = UILabel()
        label.initialize(text: data, color: .black, font: boldFont(size: 14), alignment: .left, lines: 0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.initalize(axis: .vertical, alignment: .fill, distribution: .fillEqually, spacing: 5)
        stackView.addAranagedSubviews(views: [textLabel, dataLabel])
        return stackView
    }()
    
    let contentView = UIView()
    contentView.addSubviews(views: [icon, horizontalStackView])
    
    let iconConstraints = Constraints(childView: icon, parentView: contentView, constraints: [
        Constraint(constraintType: .leading, multiplier: 1, constant: 0),
        Constraint(constraintType: .width, multiplier: 1, constant: 40)
    ])
    iconConstraints.addConstraints()
    NSLayoutConstraint.activate([
        icon.topAnchor.constraint(equalTo: textLabel.topAnchor),
        icon.heightAnchor.constraint(equalTo: textLabel.heightAnchor)
    ])
    
    let horizontalStackViewConstraints = Constraints(childView: horizontalStackView, parentView: contentView, constraints: [
        Constraint(constraintType: .vertical, multiplier: 1, constant: 0),
        Constraint(constraintType: .proportionalHeight, multiplier: 1, constant: 0),
        Constraint(constraintType: .trailing, multiplier: 1, constant: -12)
    ])
    horizontalStackViewConstraints.addConstraints()
    NSLayoutConstraint.activate([horizontalStackView.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 5)])
    
    return contentView
}
