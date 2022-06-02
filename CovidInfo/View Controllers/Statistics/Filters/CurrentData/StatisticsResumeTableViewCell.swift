//
//  StatisticsResumeTableViewCell.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 02.06.2022.
//

import UIKit

class StatisticsResumeTableViewCell: UITableViewCell {

    var titleText: String?
    var subtitleText: String?
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.initialize(text: titleText!, color: .black, font: boldFont(size: 18), alignment: .left, lines: 0)
        return label
    }()
    
    lazy var subtitle: UILabel = {
        let label = UILabel()
        label.initialize(text: subtitleText!, color: .black, font: boldFont(size: 16), alignment: .left, lines: 0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.initalize(axis: .vertical, alignment: .fill, distribution: .fill, spacing: 4)
        stackView.addAranagedSubviews(views: [title, subtitle])
        return stackView
    }()
    
    func setup(){
        contentView.addSubview(stackView)
        
        let stackViewConstraints = Constraints(childView: stackView, parentView: contentView, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 12),
            Constraint(constraintType: .trailing, multiplier: 1, constant: -12),
            Constraint(constraintType: .top, multiplier: 1, constant: 5),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 5)
        ])
        stackViewConstraints.addConstraints()
    }
}
