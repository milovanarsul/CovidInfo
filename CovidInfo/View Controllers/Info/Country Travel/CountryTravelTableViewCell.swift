//
//  CountryTravelTableViewCell.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 27.05.2022.
//

import UIKit

class CountryTravelTableViewCell: UITableViewCell {
    
    var data: CountryTravelModel? {
        didSet {
            guard let data = data else { return }
            if let icon = data.icon {
                iconImageView.image = UIImage(systemName: icon)!
            }
            
            if let title = data.title {
                titleLabel.initialize(text: title, color: .black, font: boldFont(size: 18), alignment: .left, lines: 0)
            }
            
            if let subtitle = data.subtitle {
                subtitleLabel.initialize(text: subtitle.first!.key, color: subtitle.first!.value, font: boldFont(size: 16), alignment: .left, lines: 0)
            }
            
            if let text = data.text {
                labelText.initialize(text: text, color: .black, font: UIFont(name: "IBMPlexSans-Regular", size: 12)!, alignment: .left, lines: 0)
                textIsPresent()
            } else {
                textIsNotPresent()
            }
        }
    }
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var titleSubtitleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.initalize(axis: .vertical, alignment: .fill, distribution: .fill, spacing: 2)
        stackView.addAranagedSubviews(views: [titleLabel, subtitleLabel])
        return stackView
    }()
    
    lazy var labelText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var containerview: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup(data: CountryTravelModel, type: CountryTravelTableViewCellType?){
        contentView.backgroundColor = .clear
        contentView.addSubview(containerview)
        
        if type == .normal {
            containerview.layer.cornerRadius = 8
            containerview.clipsToBounds = true
            
            let containerViewConstraints = Constraints(childView: containerview, parentView: contentView, constraints: [
                Constraint(constraintType: .leading, multiplier: 1, constant: 12),
                Constraint(constraintType: .trailing, multiplier: 1, constant: -12),
                Constraint(constraintType: .top, multiplier: 1, constant: 8),
                Constraint(constraintType: .bottom, multiplier: 1, constant: 8)
            ])
            containerViewConstraints.addConstraints()
        } else {
            defaultConstraints(childView: containerview, parentView: contentView)
        }
        
        containerview.addSubviews(views: [iconImageView, titleSubtitleStackView])
        self.data = data
    }
    
    func textIsNotPresent(){
        let iconImageViewConstraints = Constraints(childView: iconImageView, parentView: containerview, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 12),
            Constraint(constraintType: .vertical, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 0.1, constant: 0),
            Constraint(constraintType: .aspectRatio, multiplier: ( 1.0 / 1.0), constant: 0)
        ])
        iconImageViewConstraints.addConstraints()
        
        let titleSubtitleStackViewConstraints = Constraints(childView: titleSubtitleStackView, parentView: containerview, constraints: [
            Constraint(constraintType: .vertical, multiplier: 1, constant: 0),
            Constraint(constraintType: .trailing, multiplier: 1, constant: -12)
        ])
        titleSubtitleStackViewConstraints.addConstraints()
        titleSubtitleStackView.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12).isActive = true
        titleSubtitleStackView.heightAnchor.constraint(equalTo: iconImageView.heightAnchor).isActive = true
    }
    
    func textIsPresent(){
        let iconImageViewConstraints = Constraints(childView: iconImageView, parentView: containerview, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 12),
            Constraint(constraintType: .top, multiplier: 1, constant: 10),
            Constraint(constraintType: .proportionalWidth, multiplier: 0.1, constant: 0),
            Constraint(constraintType: .aspectRatio, multiplier: ( 1.0 / 1.0), constant: 0)
        ])
        iconImageViewConstraints.addConstraints()
        
        let titleSubtitleStackViewConstraints = Constraints(childView: titleSubtitleStackView, parentView: containerview, constraints: [
            Constraint(constraintType: .top, multiplier: 1, constant: 10),
            Constraint(constraintType: .trailing, multiplier: 1, constant: -12)
        ])
        titleSubtitleStackViewConstraints.addConstraints()
        titleSubtitleStackView.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12).isActive = true
        titleSubtitleStackView.heightAnchor.constraint(equalTo: iconImageView.heightAnchor).isActive = true
        
        containerview.addSubview(labelText)
        
        let textLabelConstraints = Constraints(childView: labelText, parentView: containerview, constraints: [
            Constraint(constraintType: .trailing, multiplier: 1, constant: -12),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 5)
        ])
        textLabelConstraints.addConstraints()
        
        labelText.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12).isActive = true
        labelText.topAnchor.constraint(equalTo: titleSubtitleStackView.bottomAnchor, constant: 3).isActive = true
    }
}
