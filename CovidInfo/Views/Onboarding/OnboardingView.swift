//
//  OnboardingView.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 07.06.2022.
//

import UIKit
import Lottie

class OnboardingView: UIView {
    
    var data: OnboardingData!
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: data.image)!
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.initialize(text: data.labelText, color: .black, font: boldFont(size: 16), alignment: .center, lines: 0)
        return label
    }()
    
    lazy var buttonStack: UIStackView = {
        lazy var nextButton: UIButton = {
            let button = UIButton()
            button.initialize(title: data.nextButtonText, titleColor: .white, cornerRadius: 24, font: boldFont(size: 14), backgroundColor: signatureDarkBlue, contentInsets: NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
            button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
            button.tag = 1
            return button
        }()
        
        lazy var skipButton: UIButton = {
            let button = UIButton()
            button.initialize(title: data.skipButtonText, titleColor: .white, cornerRadius: 24, font: boldFont(size: 14), backgroundColor: signatureLightBlue, contentInsets: NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
            button.isHidden = !data.isSkipEnabled
            button.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
            button.tag = 2
            return button
        }()
        
        let stackView = UIStackView()
        stackView.initalize(axis: .vertical, alignment: .fill, distribution: .fill, spacing: 18)
        stackView.addAranagedSubviews(views: [nextButton, skipButton])
        
        return stackView
    }()
    
    lazy var activityView: UIActivityIndicatorView = {
        let activityViewIndicator = UIActivityIndicatorView()
        activityViewIndicator.style = .large
        activityViewIndicator.isHidden = true
        activityViewIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityViewIndicator
    }()
    
    init(data: OnboardingData){
        self.data = data
        super.init(frame: .zero)
        
        delegates.onboardingView = self
        setup()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    func setup(){
        addSubviews(views: [imageView, descriptionLabel, activityView,buttonStack])
        
        let animationViewConstraints = Constraints(childView: imageView, parentView: self, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .vertical, multiplier: 1, constant: -40),
            Constraint(constraintType: .proportionalHeight, multiplier: 0.35, constant: 0),
            Constraint(constraintType: .aspectRatio, multiplier: (1.0/1.0), constant: 0)
        ])
        animationViewConstraints.addConstraints()
        
        let labelConstraints = Constraints(childView: descriptionLabel, parentView: self, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .leading, multiplier: 1, constant: 36)
        ])
        labelConstraints.addConstraints()
        
        let buttonStackConstraints = Constraints(childView: buttonStack, parentView: self, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 0.5, constant: 0),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 30)
        ])
        buttonStackConstraints.addConstraints()
        buttonStack.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30).isActive = true
        
        activityView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 50).isActive = true
        
    }
    
    @objc func nextButtonTapped(){
        let currentIndex = delegates.onboardingPVC.getCurrentIndex!()
        
        switch currentIndex{
        case 5:
            delegates.onboarding.enrollCertifficate()
        case 6:
            AppDelegate.locationManager.requestWhenInUseAuthorization()
            buttonStack.isHidden = true
            activityView.isHidden = false
            activityView.startAnimating()
        default:
            delegates.onboardingPVC.nextPage!()
        }
    }
    
    @objc func skipButtonTapped(){
        delegates.onboardingPVC.nextPage!()
    }
}

extension OnboardingView: OnboardingViewDelegate{
    func hideNextButton(){
        self.viewWithTag(1)?.isHidden = true
    }
    
    func manualLocation(){
        
    }
}
