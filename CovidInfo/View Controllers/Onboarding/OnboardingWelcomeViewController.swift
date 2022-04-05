//
//  WelcomeOnboardingViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 11.02.2022.
//

import UIKit

class OnboardingWelcomeViewController: UIViewController {
    
    lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "FirstOnboarding")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.dropShadow = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.dropShadow = true
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.initialize(text: "Salut!", color: signatureDarkBlue, font: boldFont(size: 60), alignment: .center, lines: 1)
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.initialize(text: "Suntem incantati de cunostinta", color: .black, font: boldFont(size: 20), alignment: .center, lines: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var instructionsLabel: UILabel = {
        let label = UILabel()
        label.initialize(text: "In urmatoarele momente iti vom\nprezenta functionalitatiile\naplicatiei", color: .black, font: boldFont(size: 16), alignment: .center, lines: 0)
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
        stackView.initalize(axis: .horizontal, alignment: .fill, distribution: .fill, spacing: 40)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    var containerViewWidthConstraint = NSLayoutConstraint()
    var containerViewHeightConstraint = NSLayoutConstraint()
    var containerViewVerticalConstraint = NSLayoutConstraint()
    
    func setup(){
        view.addSubviews(views: [backgroundImage, containerView])
        
        containerView.addSubview(contentView)
        contentView.addSubviews(views: [titleLabel, subtitleLabel, instructionsLabel, buttonStackView, logoImageView])
        
        defaultConstraints(childView: backgroundImage, parentView: view)
        
        assignConstraints(childView: containerView, parentView: view, constraints: [
            (variable: nil, type: .horizontal, constraintType: .multiplier, value: 1),
            (variable: containerViewWidthConstraint, type: .proportionalWidth, constraintType: .multiplier, value: 1),
            (variable: containerViewHeightConstraint, type: .proportionalHeight, constraintType: .multiplier, value: 1),
            (variable: containerViewVerticalConstraint, type: .vertical, constraintType: .multiplier, value: 1),
        ])
        
        defaultConstraints(childView: contentView, parentView: containerView)
        
        let titleLabelConstraints = Constraints(childView: titleLabel, parentView: contentView, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .top, multiplier: 1, constant: 30)
        ])
        titleLabelConstraints.addConstraints()
        
        NSLayoutConstraint.activate([Constraint(childView: subtitleLabel, parentView: contentView, constraintType: .horizontal, multiplier: 1, constant: 0).setConstraint(), NSLayoutConstraint(item: subtitleLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 10)])
        
        NSLayoutConstraint.activate([Constraint(childView: logoImageView, parentView: contentView, constraintType: .horizontal, multiplier: 1, constant: 0).setConstraint(), NSLayoutConstraint(item: contentView, attribute: .bottom, relatedBy: .equal, toItem: logoImageView, attribute: .bottom, multiplier: 1, constant: 10)])
        
        NSLayoutConstraint.activate([Constraint(childView: buttonStackView, parentView: contentView, constraintType: .horizontal, multiplier: 1, constant: 0).setConstraint(), Constraint(childView: buttonStackView, parentView: contentView, constraintType: .proportionalWidth, multiplier: 0.9, constant: 0).setConstraint(), NSLayoutConstraint(item: logoImageView, attribute: .top, relatedBy: .equal, toItem: buttonStackView, attribute: .bottom, multiplier: 1, constant: 30)])
        
        NSLayoutConstraint.activate([Constraint(childView: instructionsLabel, parentView: contentView, constraintType: .horizontal, multiplier: 1, constant: 0).setConstraint(), Constraint(childView: buttonStackView, parentView: contentView, constraintType: .proportionalWidth, multiplier: 0.9, constant: 0).setConstraint(), NSLayoutConstraint(item: buttonStackView, attribute: .top, relatedBy: .equal, toItem: instructionsLabel, attribute: .bottom, multiplier: 1, constant: 30)])
    }
    
    @objc func startOnboarding(_ sender: UIButton) {
        contentView.isHidden = true
        containerViewHeightConstraint.changeMultiplier(multiplier: 0.8)
        
        UIView.animate(withDuration: defaultAnimationDuration, animations: {
            self.containerView.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }, completion: { (finished: Bool) in
            self.presentView(view: OnboardingViewController(), animated: false, presentationStyle: .fullScreen, dismissPrevious: true)
            self.removeFromParent()
        })
        
    }
    
    @objc func skipTutorial(_ sender: UIButton) {
        contentView.isHidden = true
        containerViewWidthConstraint.changeMultiplier(multiplier: 1)
        containerViewHeightConstraint.changeMultiplier(multiplier: 0.89)
        NSLayoutConstraint.deactivate([containerViewVerticalConstraint])
        NSLayoutConstraint.activate([NSLayoutConstraint(item: view!, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1, constant: 0)])
        
        UIView.animate(withDuration: defaultAnimationDuration, animations: {
            self.containerView.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }, completion: {(finished: Bool) in
            self.presentView(view: MainViewController(), animated: false, presentationStyle: .fullScreen, dismissPrevious: true)
            self.removeFromParent()
        })
    }
}
