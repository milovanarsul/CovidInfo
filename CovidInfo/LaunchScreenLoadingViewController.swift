//
//  LaunchScreenLoadingViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 03.06.2022.
//

import UIKit

class LaunchScreenLoadingViewController: UIViewController {
    
    lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "LaunchScreenBackground")!
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Icon & Title")!
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var subtitleImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "An app by Milovan Arsul")!
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

       setup()
    }
    
    func setup(){
        view.addSubviews(views: [backgroundImage, logoImage, subtitleImage, activityIndicator])
        
        let backgroundImageConstraints = Constraints(childView: backgroundImage, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .top, multiplier: 1, constant: -3),
            Constraint(constraintType: .bottom, multiplier: 1, constant: -3)
        ])
        backgroundImageConstraints.addConstraints()
        
        let logoImageConstraints = Constraints(childView: logoImage, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .vertical, multiplier: 1, constant: 0),
            Constraint(constraintType: .aspectRatio, multiplier: (1.0 / 1.0), constant: 0),
            Constraint(constraintType: .leading, multiplier: 1, constant: 140)
        ])
        logoImageConstraints.addConstraints()
        
        let subtitleImageConstraints = Constraints(childView: subtitleImage, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .height, multiplier: 1, constant: 25),
            Constraint(constraintType: .leading, multiplier: 1, constant: 120),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 34)
        ])
        subtitleImageConstraints.addConstraints()
        
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: subtitleImage.topAnchor, constant: -30).isActive = true
        activityIndicator.startAnimating()
    }

}
