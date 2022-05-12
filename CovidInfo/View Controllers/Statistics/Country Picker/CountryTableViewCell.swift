//
//  CountryTableViewCell.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 10.05.2022.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    
    var country: Country? {
        didSet {
            guard let countryItem = country else {return}
            if let flag = countryItem.image {
                flagImageView.image = UIImage(named: flag)!
            }
            
            if let name = countryItem.name {
                nameLabel.initialize(text: name, color: .black, font: boldFont(size: 14), alignment: .left, lines: 0)
            }
        }
    }
    
    lazy var flagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 29.5
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup(){
        contentView.addSubviews(views: [flagImageView, nameLabel])
        
        let flagImageViewConstraints = Constraints(childView: flagImageView, parentView: contentView, constraints: [
            Constraint(constraintType: .vertical, multiplier: 1, constant: 0),
            Constraint(constraintType: .leading, multiplier: 1, constant: 24),
            Constraint(constraintType: .proportionalWidth, multiplier: 0.15, constant: 0),
            Constraint(constraintType: .aspectRatio, multiplier: (1.0/1.0), constant: 0)
        ])
        flagImageViewConstraints.addConstraints()
        
        let nameLabelConstraints = Constraints(childView: nameLabel, parentView: contentView, constraints: [
            Constraint(constraintType: .vertical, multiplier: 1, constant: 0)
        ])
        nameLabelConstraints.addConstraints()
        NSLayoutConstraint.activate([nameLabel.leadingAnchor.constraint(equalTo: flagImageView.trailingAnchor, constant: 24)])
    }
}

class CountryTableViewHeader: UITableViewHeaderFooterView {
    
    var title: String? {
        didSet{
            titleLabel.initialize(text: title!, color: .black, font: boldFont(size: 24), alignment: .left, lines: 1)
        }
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(reuseIdentifier: String?){
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setup(){
        contentView.addSubview(titleLabel)
        
        let titleConstraints = Constraints(childView: titleLabel, parentView: contentView, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 24),
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .top, multiplier: 1, constant: 15),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 15)
        ])
        titleConstraints.addConstraints()
    }
}
