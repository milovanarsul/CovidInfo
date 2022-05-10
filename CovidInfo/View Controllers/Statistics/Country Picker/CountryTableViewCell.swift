//
//  CountryTableViewCell.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 10.05.2022.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    
    var country: CountryModel? {
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
    
    lazy var isCellSelected: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "")
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        return imageView
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        print("this got selected")
    }

}
