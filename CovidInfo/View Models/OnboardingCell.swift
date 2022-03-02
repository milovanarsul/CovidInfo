//
//  OnboardingCell.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 12.02.2022.
//

import UIKit

class OnboardingCell: UIView{
    private var label = UILabel()
    private var nextButton = UIButton()
    private var skipButton = UIButton()
    private var buttonStack = UIStackView()
    private var isModalNext: Bool!
    
    func setup(labelText: String, isModalNext: Bool){
        self.isModalNext = isModalNext
        
        label.initialize(text: labelText, color: .black, font: boldFont(size: 16), alignment: .center, lines: 0)
        nextButton.initialize(title: "Mai departe", titleColor: .white, cornerRadius: 24, font: boldFont(size: 14), backgroundColor: signatureDarkBlue, contentInsets: NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
        skipButton.initialize(title: "Mai tarziu", titleColor: .white, cornerRadius: 24, font: boldFont(size: 14), backgroundColor: signatureLightBlue, contentInsets: NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
        
        buttonStack.initalize(axis: .vertical, alignment: .fill, distribution: .fill, spacing: 18)
        buttonStack.addArrangedSubview(nextButton)
        buttonStack.addArrangedSubview(skipButton)
        
        self.addSubview(label)
        self.addSubview(buttonStack)
        
        constraints()
        
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        skipButton.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        
        self.skipButton.isHidden = !isModalNext
    }
    
    @objc func nextButtonTapped(){
        self.isModalNext ? delegates.onboarding.modalView!():delegates.onboarding.nextPage!()
    }
    
    @objc func skipButtonTapped(){
        self.isModalNext ? delegates.onboarding.nextPage!():delegates.onboarding.modalView!()
    }
    
    func constraints(){
        labelConstraints()
        buttonStackConstraints()
        
        NSLayoutConstraint.activate([NSLayoutConstraint.init(item: buttonStack, attribute: .top, relatedBy: .equal, toItem: label, attribute: .bottom, multiplier: 1, constant: 30)])
    }
    
    func labelConstraints(){
        let constraints = Constraints(childView: label, parentView: self, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .leading, multiplier: 1, constant: 36)
        ])
        constraints.addConstraints()
    }
    
    func buttonStackConstraints(){
        let constraints = Constraints(childView: buttonStack, parentView: self, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 20),
            Constraint(constraintType: .proportionalWidth, multiplier: 0.35, constant: 0)
        ])
        constraints.addConstraints()
    }
}
