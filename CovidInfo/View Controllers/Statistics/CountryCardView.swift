//
//  CountryCardView.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 12.05.2022.
//

import Foundation
import UIKit

class CountryCardView: UIView {
    
    var isoCountry: String?
    var data: CurrentData?
    
    lazy var shadowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 10
        view.layer.shadowOffset = CGSize(width: -1, height: 2)
        return view
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white.withAlphaComponent(0.20)
        view.layer.cornerRadius = 24
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var countryFlag: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: isoCountry!)!
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var countryDescription: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        lazy var countryName: UILabel = {
            let label = UILabel()
            label.initialize(text: (data?.location)!, color: .black, font: boldFont(size: 24), alignment: .left, lines: 0)
            return label
        }()
        
        lazy var horizontalStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.initalize(axis: .horizontal, alignment: .fill, distribution: .fillEqually, spacing: 10)
            stackView.addAranagedSubviews(views: [
                iconText(icon: "globe.europe.africa", text: (data?.continent)!),
                iconText(icon: "person.2", text: String((data?.population)!) + " locuitori")
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
        
        let view1 = iconTextData(icon: "person", text: "Media de varsta", data: String((data?.median_age)!) + " ani")
        let view2 = iconTextData(icon: "waveform.path.ecg", text: "Risc de atac\ncardiovascular", data: String((data?.cardiovasc_death_rate)!))
        let view3 = iconTextData(icon: "staroflife", text: "Risc diabet", data: String((data?.diabetes_prevalence)!))
        let view4 = iconTextData(icon: "cross", text: "Paturi de spital\nper mia de locuitori", data: String((data?.hospital_beds_per_thousand)!))
        
        let stackView = UIStackView()
        stackView.initalize(axis: .vertical, alignment: .fill, distribution: .fillEqually, spacing: 15)
        stackView.addAranagedSubviews(views: [
            iconTextDataHorizontalStackView(view1: view1, view2: view2),
            iconTextDataHorizontalStackView(view1: view3, view2: view4)
        ])
    
        return stackView
    }()
    
    init(isoCountry: String, data: CurrentData){
        self.isoCountry = isoCountry
        self.data = data
        super.init(frame: .zero)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    func setup(){
        
        addSubviews(views: [shadowView, contentView])
        defaultAnchors(childView: shadowView, parentView: contentView)
        defaultConstraints(childView: contentView, parentView: self)
        
        contentView.addSubviews(views: [countryFlag, countryDescription, separator, informationStackView])
        
        let countryFlagConstraints = Constraints(childView: countryFlag, parentView: contentView, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalHeight, multiplier: 0.4, constant: 0),
            Constraint(constraintType: .top, multiplier: 1, constant: 0)
        ])
        countryFlagConstraints.addConstraints()
        
        let countryDescriptionConstraints = Constraints(childView: countryDescription, parentView: contentView, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalHeight, multiplier: 0.25, constant: 0)
        ])
        countryDescriptionConstraints.addConstraints()
        NSLayoutConstraint.activate([countryDescription.topAnchor.constraint(equalTo: countryFlag.bottomAnchor, constant: 0)])
        
        let separatorConstraints = Constraints(childView: separator, parentView: contentView, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 20),
            Constraint(constraintType: .trailing, multiplier: 1, constant: -20),
            Constraint(constraintType: .height, multiplier: 1, constant: 2)
        ])
        separatorConstraints.addConstraints()
        NSLayoutConstraint.activate([separator.topAnchor.constraint(equalTo: countryDescription.bottomAnchor, constant: 5)])
        
        let informationStackViewConstraints = Constraints(childView: informationStackView, parentView: contentView, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 10),
            Constraint(constraintType: .trailing, multiplier: 1, constant: -10),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 5)
        ])
        informationStackViewConstraints.addConstraints()
        NSLayoutConstraint.activate([informationStackView.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 20)])
    }
    
    func iconText(icon: String, text: String) -> UIView{
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
    
    func iconTextDataHorizontalStackView(view1: UIView, view2: UIView) -> UIStackView{
        lazy var stackView: UIStackView = {
            let stackView = UIStackView()
            stackView.initalize(axis: .horizontal, alignment: .fill, distribution: .fillEqually, spacing: 10)
            stackView.addAranagedSubviews(views: [view1, view2])
            return stackView
        }()
        
        return stackView
    }
}
