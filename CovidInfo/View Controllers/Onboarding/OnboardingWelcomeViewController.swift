//
//  WelcomeOnboardingViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 11.02.2022.
//

import UIKit

class OnboardingWelcomeViewController: UIViewController {
    
    @IBOutlet var onboardingParentView: UIView!
    @IBOutlet var onboardingSubView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startOnboarding(_ sender: Any) {
        onboarding()
        
    }
    @IBAction func skipTutorial(_ sender: Any) {
        skipOnboarding()
    }
    
    @IBOutlet weak var centerConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    
    func skipOnboarding(){
        self.onboardingSubView.isHidden = true
        self.leadingConstraint.constant = 0
        self.heightConstraint.changeMultiplier(multiplier: 0.853795)
        self.view.removeConstraint(centerConstraint)
        NSLayoutConstraint.activate([NSLayoutConstraint(item: self.view!, attribute: .bottom, relatedBy: .equal, toItem: onboardingParentView, attribute: .bottom, multiplier: 1, constant: 0)])
        
        UIView.animate(withDuration: defaultAnimationDuration, animations: {
            self.onboardingParentView.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }, completion: {(finished: Bool) in
            self.presentView(view: MainViewController(), animated: false, presentationStyle: .fullScreen, dismissPrevious: true)
        })
    }
    
    func onboarding(){
        self.onboardingSubView.isHidden = true
        self.heightConstraint.changeMultiplier(multiplier: 0.8)
        
        UIView.animate(withDuration: defaultAnimationDuration, animations: {
            self.onboardingParentView.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }, completion: { (finished: Bool) in
            self.presentView(view: OnboardingViewController(), animated: false, presentationStyle: .fullScreen, dismissPrevious: true)
            self.removeFromParent()
        })
    }
}
