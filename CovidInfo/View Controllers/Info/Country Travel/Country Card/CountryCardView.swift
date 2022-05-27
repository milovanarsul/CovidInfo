//
//  CountryCardView.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 12.05.2022.
//

import Foundation
import UIKit

class CountryCardView: UITableViewCell {
    
    var data: CurrentData!
    
    lazy var parentView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 24
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var countryFlag: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: (data!.countryISO)!)!
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var countryDescription: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        lazy var countryName: UILabel = {
            let label = UILabel()
            label.initialize(text: roISOCountries[(data!.countryISO)!]!, color: .black, font: boldFont(size: 24), alignment: .left, lines: 0)
            return label
        }()
        
        lazy var horizontalStackView: UIStackView = {
            let continent = roContients[data!.continent!]
            let formattedPopulation = String(format: "%.0f", locale: Locale.current, data!.population)
            
            let stackView = UIStackView()
            stackView.initalize(axis: .horizontal, alignment: .fill, distribution: .fillEqually, spacing: 10)
            stackView.addAranagedSubviews(views: [
                iconText(icon: "globe.europe.africa", text: continent!, system: true, textColor: .black),
                iconText(icon: "person.2", text: formattedPopulation + " locuitori", system: true, textColor: .black)
            ])
            return stackView
        }()
        
        view.addSubviews(views: [countryName, horizontalStackView])
        
        let countryNameConstraints = Constraints(childView: countryName, parentView: view, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 20),
            Constraint(constraintType: .top, multiplier: 1, constant: 5)
        ])
        countryNameConstraints.addConstraints()
        
        let horizontalStackViewConstraints = Constraints(childView: horizontalStackView, parentView: view, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 20),
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 5)
        ])
        horizontalStackViewConstraints.addConstraints()
        NSLayoutConstraint.activate([horizontalStackView.topAnchor.constraint(equalTo: countryName.bottomAnchor, constant: 5)])
        
        return view
    }()
    
    lazy var separator: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    lazy var informationStackView: UIStackView = {
        
        let medianAge: Bool = (data!.median_age != 0.0)
        let cardiovasc_death_rate: Bool = (data!.cardiovasc_death_rate != 0.0)
        let diabetes_prevalence: Bool = (data!.diabetes_prevalence != 0.0)
        let hopsital_beds_per_thousand: Bool = (data!.hospital_beds_per_thousand != 0.0)
        
        let view1 = iconTextData(icon: "person", text: "Media de varsta", data: String((data!.median_age)) + " ani")
        let view2 = iconTextData(icon: "waveform.path.ecg", text: "Risc atac cardiovascular", data: String((data!.cardiovasc_death_rate)))
        let view3 = iconTextData(icon: "staroflife", text: "Risc diabet", data: String((data!.diabetes_prevalence)))
        let view4 = iconTextData(icon: "cross", text: "Paturi de spital\nper mia de locuitori", data: String((data!.hospital_beds_per_thousand)))
        
        let stackView = UIStackView()
        stackView.backgroundColor = .white
        stackView.initalize(axis: .vertical, alignment: .fill, distribution: .fillEqually, spacing: 15)
        
        stackView.addAranagedSubviews(views: [
            iconTextDataHorizontalStackView(view1: (view1, medianAge), view2: (view2, cardiovasc_death_rate)),
            iconTextDataHorizontalStackView(view1: (view3, diabetes_prevalence), view2: (view4, hopsital_beds_per_thousand))
        ])
    
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup(){
        data = (DataManager.currentData?.first)!
        contentView.addSubview(parentView)
        
        let parentViewConstraints = Constraints(childView: parentView, parentView: contentView, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 12),
            Constraint(constraintType: .trailing, multiplier: 1, constant: -12),
            Constraint(constraintType: .top, multiplier: 1, constant: 8),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 8)
        ])
        parentViewConstraints.addConstraints()
        
        parentView.addSubview(containerView)
        defaultConstraints(childView: containerView, parentView: parentView)
        
        containerView.addSubviews(views: [countryFlag, countryDescription, separator, informationStackView])
        
        let countryFlagConstraints = Constraints(childView: countryFlag, parentView: containerView, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalHeight, multiplier: 0.4, constant: 0),
            Constraint(constraintType: .top, multiplier: 1, constant: 0)
        ])
        countryFlagConstraints.addConstraints()
        
        let countryDescriptionConstraints = Constraints(childView: countryDescription, parentView: containerView, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalHeight, multiplier: 0.25, constant: 0)
        ])
        countryDescriptionConstraints.addConstraints()
        NSLayoutConstraint.activate([countryDescription.topAnchor.constraint(equalTo: countryFlag.bottomAnchor, constant: 0)])
        
        let separatorConstraints = Constraints(childView: separator, parentView: containerView, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 20),
            Constraint(constraintType: .trailing, multiplier: 1, constant: -20),
            Constraint(constraintType: .height, multiplier: 1, constant: 1)
        ])
        separatorConstraints.addConstraints()
        NSLayoutConstraint.activate([separator.topAnchor.constraint(equalTo: countryDescription.bottomAnchor, constant: 5)])
        
        let informationStackViewConstraints = Constraints(childView: informationStackView, parentView: containerView, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 10),
            Constraint(constraintType: .trailing, multiplier: 1, constant: -10),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 5)
        ])
        informationStackViewConstraints.addConstraints()
        NSLayoutConstraint.activate([informationStackView.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 20)])
    }
    
    func iconTextDataHorizontalStackView(view1: (UIView, Bool), view2: (UIView, Bool)) -> UIStackView{
        
        let stackView = UIStackView()
        stackView.initalize(axis: .horizontal, alignment: .fill, distribution: .fillEqually, spacing: -5)
        
        switch (view1.1, view2.1){
        case (true, true):
            stackView.addAranagedSubviews(views: [view1.0, view2.0])
        case (true, false):
            stackView.addSubview(view1.0)
        case (false, true):
            stackView.addSubview(view1.0)
        case (false, false):
            ()
        }
        
        return stackView
    }
}
