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
        self.presentView(view: MainViewController(), animated: false, presentationStyle: .fullScreen, dismissPrevious: true)
    }
    
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    
    func onboarding(){
        self.onboardingSubView.isHidden = true
        self.heightConstraint.changeMultiplier(multiplier: 0.8)
        
        UIView.animate(withDuration: 0.9, animations: {
            self.onboardingParentView.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }, completion: { (finished: Bool) in
            self.presentView(view: OnboardingViewController(), animated: false, presentationStyle: .fullScreen, dismissPrevious: true)
        })
    }
}
