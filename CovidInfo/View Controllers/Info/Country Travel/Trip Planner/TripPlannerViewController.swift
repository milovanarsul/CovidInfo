//
//  TripPlannerViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 27.05.2022.
//

import UIKit

class TripPlannerViewController: UIViewController {
    
    lazy var onboardingView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var onboardingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "planTrip")!
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var locationButtons: UIStackView = {
        lazy var departureButton: UIButton = {
            let button = UIButton()
            button.initialize(title: "Plecare", titleColor: .white, cornerRadius: 8, font: boldFont(size: 18), backgroundColor: signatureDarkBlue, contentInsets: NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20), image: UIImage(systemName: "airplane.departure"))
            button.addTarget(self, action: #selector(departureButtonTapped(_:)), for: .touchUpInside)
            return button
        }()
        
        lazy var arrivalButton: UIButton = {
            let button = UIButton()
            button.initialize(title: "Destinatie", titleColor: .white, cornerRadius: 8, font: boldFont(size: 18), backgroundColor: signatureDarkBlue, contentInsets: NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20), image: UIImage(systemName: "airplane.arrival"))
            return button
        }()
        
        let stackView = UIStackView()
        stackView.initalize(axis: .vertical, alignment: .fill, distribution: .fillEqually, spacing: 20)
        stackView.addAranagedSubviews(views: [departureButton, arrivalButton])
        return stackView
    }()
    
    lazy var departureView: UIView = {
        let view = TripPlannerCountryPickerView(viewType: .departure)
        return view
    }()
    
    lazy var arrivalView: UIView = {
        let view = TripPlannerCountryPickerView(viewType: .arrival)
        return view
    }()
    
    var screenWidth: CGFloat = UIScreen.main.bounds.width
    var departureViewBottomConstraint = NSLayoutConstraint()

    override func viewDidLoad() {
        super.viewDidLoad()

        delegates.tripPlanner = self
        setup()
    }
    
    func setup(){
        view.backgroundColor = .white
        
        view.addSubview(onboardingView)
        defaultConstraints(childView: onboardingView, parentView: view)
        
        onboardingView.addSubviews(views: [onboardingImageView, locationButtons, departureView])
        
        let onboardingImageViewConstraints = Constraints(childView: onboardingImageView, parentView: onboardingView, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 0.8, constant: 0),
            Constraint(constraintType: .top, multiplier: 1, constant: 50),
            Constraint(constraintType: .aspectRatio, multiplier: (1.0 / 1.0), constant: 0)
        ])
        onboardingImageViewConstraints.addConstraints()
        
        let locationButtonsConstraints = Constraints(childView: locationButtons, parentView: onboardingView, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 0.7, constant: 0),
            Constraint(constraintType: .proportionalHeight, multiplier: 0.15, constant: 0)
        ])
        locationButtonsConstraints.addConstraints()
        locationButtons.topAnchor.constraint(equalTo: onboardingImageView.bottomAnchor, constant: 30).isActive = true
        
        let departureViewConstraints = Constraints(childView: departureView, parentView: onboardingView, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalHeight, multiplier: 0.7, constant: 0)
        ])
        departureViewConstraints.addConstraints()
        departureViewBottomConstraint = departureView.bottomAnchor.constraint(equalTo: onboardingView.bottomAnchor, constant: screenWidth * 2)
        departureViewBottomConstraint.isActive = true
    }
    
    @objc func departureButtonTapped(_ sender: UIButton){
        animateLocationView(locationView: departureView, bottomConstraint: departureViewBottomConstraint, visibility: .show)
        tripPlannerPresentationShouldDismiss = false
    }
    
    func animateLocationView(locationView: UIView, bottomConstraint: NSLayoutConstraint, visibility: ViewVisibility) {
        switch visibility {
        case .show:
            bottomConstraint.constant = 0
        case .hide:
            bottomConstraint.constant = screenWidth * 2
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            locationView.layoutIfNeeded()
            self.onboardingView.layoutIfNeeded()
        })
    }
}

extension TripPlannerViewController: TripPlannerDelegate{
    func animateDepartureView(){
        animateLocationView(locationView: departureView, bottomConstraint: departureViewBottomConstraint, visibility: .hide)
    }
    
    func animateArrivalView(){
        animateLocationView(locationView: departureView, bottomConstraint: departureViewBottomConstraint, visibility: .hide)
    }
}
