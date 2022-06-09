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
    
    lazy var locationButton: UIView = {
        lazy var locationIcon: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(systemName: "location.circle")!
            imageView.contentMode = .scaleAspectFit
            imageView.tintColor = .white
            imageView.tag = 1
            return imageView
        }()
        
        lazy var flagAndName: UIView = {
            let currentCountry = "ROU"
            
            lazy var flagImageView: UIImageView = {
                let imageView = UIImageView()
                imageView.image = UIImage(named: currentCountry)!
                imageView.contentMode = .scaleAspectFill
                imageView.layer.cornerRadius = 13
                imageView.clipsToBounds = true
                return imageView
            }()
            
            lazy var countryName: UILabel = {
                let label = UILabel()
                label.initialize(text: currentCountry, color: .white, font: boldFont(size: 16), alignment: .center, lines: 1)
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
            
            let view = UIView()
            view.isHidden = true
            view.tag = 2
            view.addSubviews(views: [flagImageView, countryName])
            
            let flagImageViewConstraints = Constraints(childView: flagImageView, parentView: view, constraints: [
                Constraint(constraintType: .vertical, multiplier: 1, constant: 0),
                Constraint(constraintType: .leading, multiplier: 1, constant: 10),
                Constraint(constraintType: .proportionalHeight, multiplier: 0.6, constant: 0),
                Constraint(constraintType: .aspectRatio, multiplier: (1.0 / 1.0), constant: 0)
            ])
            flagImageViewConstraints.addConstraints()
            
            countryName.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            countryName.leadingAnchor.constraint(equalTo: flagImageView.trailingAnchor, constant: 5).isActive = true
            
            return view
        }()
        
        let view = UIView()
        view.backgroundColor = greenColor
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        
        view.addSubviews(views: [locationIcon, flagAndName])
        defaultConstraints(childView: locationIcon, parentView: view)
        defaultConstraints(childView: flagAndName, parentView: view)
        
        return view
    }()
    
    var locationButtonWidthConstraint = NSLayoutConstraint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(locationButton)
        
        let locationButtonConstraints = Constraints(childView: locationButton, parentView: view, constraints: [
            Constraint(constraintType: .vertical, multiplier: 1, constant: 0),
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .height, multiplier: 1, constant: 40)
        ])
        locationButtonConstraints.addConstraints()
        locationButtonWidthConstraint = locationButton.widthAnchor.constraint(equalToConstant: 40)
        locationButtonWidthConstraint.isActive = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0){
            self.animate(visibility: .show)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6.0){
            self.animate(visibility: .hide)
        }
    }
    
    func animate(visibility: ViewVisibility){
        switch visibility {
        case .show:
            view.viewWithTag(1)?.isHidden = true
            view.viewWithTag(2)?.isHidden = false
            locationButtonWidthConstraint.constant = 80
        case .hide:
            view.viewWithTag(2)?.isHidden = true
            locationButtonWidthConstraint.constant = 40
            view.viewWithTag(1)?.isHidden = false
        }
        
        UIView.animate(withDuration: 0.4, animations: {
            self.locationButton.layoutIfNeeded()
        })
        
    }
}
