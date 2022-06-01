//
//  TripPlannerViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 27.05.2022.
//

import UIKit

class TripPlannerViewController: UIViewController {
    
    lazy var topBar: UIView = {
        lazy var redoResultButton: UIButton = {
            let button = UIButton()
            button.initialize(title: "Inapoi", titleColor: .black, cornerRadius: 0, font: boldFont(size: 18), backgroundColor: .clear, contentInsets: NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20), image: UIImage(systemName: "arrow.backward.circle.fill"))
            button.addTarget(self, action: #selector(redoResultTapped(_:)), for: .touchUpInside)
            button.isHidden = true
            button.tag = 2
            return button
        }()
        
        lazy var closeButton: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "darkOnLight")!
            imageView.contentMode = .scaleAspectFit
            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeButtonTapped)))
            imageView.isUserInteractionEnabled = true
            return imageView
        }()
        
        let view = UIView()
        view.backgroundColor = .white
        view.addSubviews(views: [redoResultButton, closeButton])
        
        let closeButtonConstraints = Constraints(childView: closeButton, parentView: view, constraints: [
            Constraint(constraintType: .trailing, multiplier: 1, constant: -24),
            Constraint(constraintType: .aspectRatio, multiplier: (1.0 / 1.0), constant: 0),
            Constraint(constraintType: .height, multiplier: 1, constant: 25),
            Constraint(constraintType: .top, multiplier: 1, constant: 20)
        ])
        closeButtonConstraints.addConstraints()
        
        let redoResultButtonConstraints = Constraints(childView: redoResultButton, parentView: view, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 12),
            Constraint(constraintType: .top, multiplier: 1, constant: 10)
        ])
        redoResultButtonConstraints.addConstraints()
        
        return view
    }()
    
    lazy var onboardingView: UIView = {
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
                button.addTarget(self, action: #selector(arrivalButtonTapped(_:)), for: .touchUpInside)
                return button
            }()
            
            let stackView = UIStackView()
            stackView.initalize(axis: .vertical, alignment: .fill, distribution: .fillEqually, spacing: 20)
            stackView.addAranagedSubviews(views: [departureButton, arrivalButton])
            return stackView
        }()
        
        let view = UIView()
        view.addSubviews(views: [onboardingImageView, locationButtons])
        
        let onboardingImageViewConstraints = Constraints(childView: onboardingImageView, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 0.8, constant: 0),
            Constraint(constraintType: .top, multiplier: 1, constant: 50),
            Constraint(constraintType: .aspectRatio, multiplier: (1.0 / 1.0), constant: 0)
        ])
        onboardingImageViewConstraints.addConstraints()
        
        let locationButtonsConstraints = Constraints(childView: locationButtons, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 0.7, constant: 0),
            Constraint(constraintType: .proportionalHeight, multiplier: 0.15, constant: 0)
        ])
        locationButtonsConstraints.addConstraints()
        locationButtons.topAnchor.constraint(equalTo: onboardingImageView.bottomAnchor, constant: 30).isActive = true
        
        return view
    }()
    
    lazy var departureTableView: UIView = {
        let view = TripPlannerCountryPickerTableView(viewType: .departure)
        return view
    }()
    
    lazy var arrivalTableView: UIView = {
        let view = TripPlannerCountryPickerTableView(viewType: .arrival)
        return view
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityInidcator = UIActivityIndicatorView()
        activityInidcator.style = .large
        activityInidcator.startAnimating()
        activityInidcator.translatesAutoresizingMaskIntoConstraints = false
        return activityInidcator
    }()
    
    var screenWidth: CGFloat = UIScreen.main.bounds.width
    var departureViewBottomConstraint = NSLayoutConstraint()
    var arrivalViewBottomConstraint = NSLayoutConstraint()

    override func viewDidLoad() {
        super.viewDidLoad()

        delegates.tripPlanner = self
        setup()
    }
    
    func setup(){
        view.backgroundColor = .white
        
        view.addSubviews(views: [topBar, onboardingView, departureTableView, arrivalTableView])
        
        let topBarConstraints = Constraints(childView: topBar, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .top, multiplier: 1, constant: 0),
            Constraint(constraintType: .height, multiplier: 1, constant: 40)
        ])
        topBarConstraints.addConstraints()
        
        let onboardingViewConstraints = Constraints(childView: onboardingView, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 0),
        ])
        onboardingViewConstraints.addConstraints()
        onboardingView.topAnchor.constraint(equalTo: topBar.bottomAnchor, constant: 10).isActive = true
        
        let departureViewConstraints = Constraints(childView: departureTableView, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalHeight, multiplier: 0.7, constant: 0)
        ])
        departureViewConstraints.addConstraints()
        departureViewBottomConstraint = departureTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: screenWidth * 2)
        departureViewBottomConstraint.isActive = true
        
        let arrivalViewConstraints = Constraints(childView: arrivalTableView, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalHeight, multiplier: 0.7, constant: 0)
        ])
        arrivalViewConstraints.addConstraints()
        arrivalViewBottomConstraint = arrivalTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: screenWidth * 2)
        arrivalViewBottomConstraint.isActive = true
    }
    
    @objc func closeButtonTapped(){
        delegates.main.dimissModal(completion: {})
    }
    
    @objc func departureButtonTapped(_ sender: UIButton){
        animateLocationView(locationView: departureTableView, bottomConstraint: departureViewBottomConstraint, visibility: .show)
        tripPlannerPresentationShouldDismiss = false
    }
    
    @objc func arrivalButtonTapped(_ sender: UIButton){
        animateLocationView(locationView: arrivalTableView, bottomConstraint: arrivalViewBottomConstraint, visibility: .show)
        tripPlannerPresentationShouldDismiss = false
    }
    
    @objc func redoResultTapped(_ sender: UIButton){
        view.viewWithTag(2)?.isHidden = true
        view.viewWithTag(3)!.removeFromSuperview()
        view.backgroundColor = .white
        onboardingView.isHidden = false
        
        arrivalCountry = nil
        departureCountry = nil
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
            self.view.layoutIfNeeded()
        })
    }
}

extension TripPlannerViewController: TripPlannerDelegate{
    func animateDepartureView(){
        animateLocationView(locationView: departureTableView, bottomConstraint: departureViewBottomConstraint, visibility: .hide)
    }
    
    func animateArrivalView(){
        animateLocationView(locationView: arrivalTableView, bottomConstraint: arrivalViewBottomConstraint, visibility: .hide)
    }
    
    func result(){
        onboardingView.isHidden = true
        view.backgroundColor = UIColor("#f2f2f7")
        topBar.backgroundColor = UIColor("#f2f2f7")
        view.addSubview(activityIndicator)
        xyConstraints(childView: activityIndicator, parentView: view)
        activityIndicator.startAnimating()
        
        let arrivalCountryISO = countryToISO(country: arrivalCountry!.name!, dictionary: roISOCountries)
        let departureCountryISO = countryToISO(country: departureCountry!.name!, dictionary: roISOCountries)
        var arrivalCountryDataArray: [CountryTravelModel]?
        var departureCountryDataArray: [CountryTravelModel]?
        
        AmadeusManager.loadData(country: arrivalCountryISO!){ result in
            arrivalCountryDataArray = result
        }
        
        AmadeusManager.loadData(country: departureCountryISO!) { result in
            departureCountryDataArray = result
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) { [self] in
            activityIndicator.removeFromSuperview()
            view.viewWithTag(2)?.isHidden = false
            let resultView = TripPlannerResultView(arrivalData: arrivalCountryDataArray!, departureData: departureCountryDataArray!)
            resultView.tag = 3
            view.addSubviews(views: [resultView])
            
            let resultViewConstraints = Constraints(childView: resultView, parentView: view, constraints: [
                Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
                Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
                Constraint(constraintType: .bottom, multiplier: 1, constant: 0)
            ])
            resultViewConstraints.addConstraints()
            resultView.topAnchor.constraint(equalTo: topBar.bottomAnchor, constant: 10).isActive = true
            
            departureCountry = nil
            arrivalCountry = nil
        }
    }
}

