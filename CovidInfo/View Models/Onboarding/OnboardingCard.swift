//
//  OnboardingCard.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 11.02.2022.
//

import UIKit
import Lottie

class OnboardingCard: XIB {
    var animation: AnimationView!
    @IBOutlet var label: UILabel!
    @IBOutlet var maiDeparteButton: UIButton!
    @IBOutlet var maiTarziuButton: UIButton!
    
    var isModalNext: Bool!
    var animationName: String!
    
    convenience init(animationName: String, labelText: String, isModalNext: Bool) {
        self.init()
        self.animationName = animationName
        self.label.text = labelText
        self.isModalNext = isModalNext
        
        if isModalNext{
            self.maiTarziuButton.isHidden = false
        }
        
        setupLottieAnimation()
    }
    
    @IBAction func maiDeparteButtonPressed(_ sender: Any) {
        self.isModalNext ? delegates.onboarding.modal():delegates.onboarding.goToPage()
        self.animation.play()
    }
    
    @IBAction func maiTarziuButtonPressed(_ sender: Any) {
        self.isModalNext ? delegates.onboarding.goToPage():delegates.onboarding.modal()
    }
    
    func setupLottieAnimation(){
        let lottieAnimation = AnimationView(animation: Animation.named(""))
        lottieAnimation.contentMode = .scaleAspectFit
        lottieAnimation.loopMode = .loop
        lottieAnimation.animationSpeed = 0.5
        
        self.addSubview(lottieAnimation)
        
        let constraints = Constraints(childView: lottieAnimation, parentView: self, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .leading, multiplier: 1, constant: 40),
            Constraint(constraintType: .top, multiplier: 1, constant: 0),
            Constraint(constraintType: .aspectRatio, multiplier: (1.0 / 1.0), constant: 0),
        ])
        
        constraints.addConstraints()
        self.animation = lottieAnimation
        
        NSLayoutConstraint.activate([NSLayoutConstraint(item: self.label!, attribute: .top, relatedBy: .equal, toItem: self.animation, attribute: .bottom, multiplier: 1, constant: 30)])
        
        self.animation.animation = Animation.named(self.animationName)
        self.animation.play()
    }
}

extension OnboardingCard: OnboardingDelegate{
    func goToPage() {}
    
    func modal() {}
    
    func dismissModal() {}
    
    func playAnimation(){
        self.animation.play()
    }
}
