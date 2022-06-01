//
//  TestViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 02.04.2022.
//
//  StatisticsGraphs.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 12.04.2022.
//

import UIKit

class TestViewController: UIViewController {
    
    var data: CountryTravelModel?
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: (data?.icon)!)!
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.initialize(text: (data?.title)!, color: .black, font: boldFont(size: 18), alignment: .left, lines: 0)
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.initialize(text: data!.subtitle!.first!.key, color: data!.subtitle!.first!.value, font: boldFont(size: 14), alignment: .left, lines: 0)
        return label
    }()
    
    lazy var titleSubtitleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.initalize(axis: .vertical, alignment: .fill, distribution: .fill, spacing: 0)
        stackView.addAranagedSubviews(views: [titleLabel, subtitleLabel])
        return stackView
    }()
    
    lazy var testView: UIView = {
        let view = UIView()
        return view
    }()
    
    init(data: CountryTravelModel){
        self.data = data
        super.init(nibName: nil, bundle: nil)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup(){
        view.backgroundColor = .black
        view.addSubview(testView)
        
        let testViewConstraints = Constraints(childView: testView, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .vertical, multiplier: 1, constant: 0),
            Constraint(constraintType: .height, multiplier: 1, constant: 100),
            Constraint(constraintType: .proportionalWidth, multiplier: 0.8, constant: 0)
        ])
        testViewConstraints.addConstraints()
        
        testView.layer.cornerRadius = 8
        testView.clipsToBounds = true
        testView.backgroundColor = signatureLightBlue
        
        testView.addSubviews(views: [iconImageView, titleSubtitleStackView])
        
        if (data?.text) == nil {
            let iconImageViewConstraints = Constraints(childView: iconImageView, parentView: testView, constraints: [
                Constraint(constraintType: .leading, multiplier: 1, constant: 12),
                Constraint(constraintType: .vertical, multiplier: 1, constant: 0),
                Constraint(constraintType: .proportionalHeight, multiplier: 0.9, constant: 0),
                Constraint(constraintType: .aspectRatio, multiplier: ( 1.0 / 1.0), constant: 0)
            ])
            iconImageViewConstraints.addConstraints()
        } else {
            let iconImageViewConstraints = Constraints(childView: iconImageView, parentView: testView, constraints: [
                Constraint(constraintType: .leading, multiplier: 1, constant: 12),
                Constraint(constraintType: .top, multiplier: 1, constant: 10),
                Constraint(constraintType: .proportionalHeight, multiplier: 0.4, constant: 0),
                Constraint(constraintType: .aspectRatio, multiplier: ( 1.0 / 1.0), constant: 0)
            ])
            iconImageViewConstraints.addConstraints()
        }
        
        let titleSubtitleStackViewConstraints = Constraints(childView: titleSubtitleStackView, parentView: testView, constraints: [
            Constraint(constraintType: .top, multiplier: 1, constant: 10),
            Constraint(constraintType: .trailing, multiplier: 1, constant: -12)
        ])
        titleSubtitleStackViewConstraints.addConstraints()
        titleSubtitleStackView.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12).isActive = true
        titleSubtitleStackView.heightAnchor.constraint(equalTo: iconImageView.heightAnchor).isActive = true
        
        if let text = data?.text {
            textSetup(text: text)
        }
    }
    
    func textSetup(text: String){
        lazy var textLabel: UILabel = {
            let label = UILabel()
            label.initialize(text: text, color: .black, font: UIFont(name: "IBMPlexSans-Regular", size: 12)!, alignment: .left, lines: 0)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        testView.addSubview(textLabel)
        
        let textLabelConstraints = Constraints(childView: textLabel, parentView: testView, constraints: [
            Constraint(constraintType: .trailing, multiplier: 1, constant: -12),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 5)
        ])
        textLabelConstraints.addConstraints()
        
        textLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12).isActive = true
        textLabel.topAnchor.constraint(equalTo: titleSubtitleStackView.bottomAnchor, constant: 5).isActive = true
    }
    
}
