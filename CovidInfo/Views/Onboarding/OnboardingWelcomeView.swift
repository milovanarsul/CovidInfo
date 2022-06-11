//
//  OnboardingWelcomeView.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 07.06.2022.
//

import UIKit

class OnboardingWelcomeView: UIView {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.initialize(text: "Salut!", color: signatureDarkBlue, font: boldFont(size: 60), alignment: .center, lines: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.initialize(text: "Suntem încântați de cunoștință", color: .black, font: boldFont(size: 20), alignment: .center, lines: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var instructionsLabel: UILabel = {
        let label = UILabel()
        label.initialize(text: "În următoarele momente îți vom\nprezenta funcționalitățiile\naplicației", color: .black, font: boldFont(size: 16), alignment: .center, lines: 0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var skipTutorialButton: UIButton = {
        let button = UIButton()
        button.initialize(title: "Omite tutorialul", titleColor: .white, cornerRadius: 24, font: boldFont(size: 14), backgroundColor: signatureLightBlue, contentInsets: NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
        button.addTarget(self, action: #selector(skipTutorial(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var startTutorialButton: UIButton = {
        let button = UIButton()
        button.initialize(title: "Mai departe", titleColor: .white, cornerRadius: 24, font: boldFont(size: 14), backgroundColor: signatureDarkBlue, contentInsets: NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
        button.addTarget(self, action: #selector(startOnboarding(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.initalize(axis: .horizontal, alignment: .fill, distribution: .fill, spacing: 30)
        stackView.addArrangedSubview(skipTutorialButton)
        stackView.addArrangedSubview(startTutorialButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Icon & Title - Horizontal")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    init(){
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    func setup(){
        addSubviews(views: [titleLabel, subtitleLabel, instructionsLabel, buttonStackView, logoImageView])
        
        let titleLabelConstraints = Constraints(childView: titleLabel, parentView: self, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .top, multiplier: 1, constant: 30)
        ])
        titleLabelConstraints.addConstraints()
        
        subtitleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        
        logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 10).isActive = true
        
        let buttonStackViewConstraints = Constraints(childView: buttonStackView, parentView: self, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 0.9, constant: 0)
        ])
        buttonStackViewConstraints.addConstraints()
        logoImageView.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: 30).isActive = true
        
        let instructionsLabelConstraints = Constraints(childView: instructionsLabel, parentView: self, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 0.9, constant: 0),
        ])
        instructionsLabelConstraints.addConstraints()
        buttonStackView.topAnchor.constraint(equalTo: instructionsLabel.bottomAnchor, constant: 30).isActive = true
    }
    
    @objc func startOnboarding(_ sender: UIButton) {
        delegates.onboarding.startTutorial()
    }
    
    @objc func skipTutorial(_ sender: UIButton) {
        delegates.onboarding.skipTutorial()
    }
}


