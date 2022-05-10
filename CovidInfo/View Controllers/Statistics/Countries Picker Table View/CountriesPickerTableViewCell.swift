//
//  CountriesPickerTableViewCell.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 10.05.2022.
//

import UIKit

class CountriesPickerTableViewCell: UITableViewCell {
    
    var country: CountryCell!
    
    lazy var countryFlag: UIImageView = {
        let imageView = imageViewRounded(image: UIImage(named: country.image)!)
        return imageView
    }()
    
    lazy var countryName: UILabel = {
        let label = UILabel()
        label.initialize(text: country.name, color: .black, font: boldFont(size: 14), alignment: .left, lines: 0)
        return label
    }()
    
    lazy var isChecked: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark.circle")
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        return imageView
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(){
        contentView.addSubviews(views: [countryFlag, countryName, isChecked])
        
        let countryFlagConstraints = Constraints(childView: countryFlag, parentView: contentView, constraints: [
            Constraint(constraintType: .vertical, multiplier: 1, constant: 0),
            Constraint(constraintType: .leading, multiplier: 1, constant: 24),
            Constraint(constraintType: .proportionalWidth, multiplier: 0.15, constant: 0),
            Constraint(constraintType: .aspectRatio, multiplier: (1.0 / 1.0), constant: 0)
        ])
        countryFlagConstraints.addConstraints()
        
        NSLayoutConstraint.activate([
            countryName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            countryName.leadingAnchor.constraint(equalTo: countryFlag.trailingAnchor, constant: 24)
        ])
        
        let isCheckedConstraints = Constraints(childView: isChecked, parentView: contentView, constraints: [
            Constraint(constraintType: .vertical, multiplier: 1, constant: 0),
            Constraint(constraintType: .trailing, multiplier: 1, constant: 24),
            Constraint(constraintType: .proportionalWidth, multiplier: 0.1, constant: 0),
            Constraint(constraintType: .aspectRatio, multiplier: (1.0 / 1.0), constant: 0)
        ])
        isCheckedConstraints.addConstraints()
        
    }

}
