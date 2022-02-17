//
//  LaunchViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 11.02.2022.
//

import UIKit

private var onboardingCompleted: Bool = false

class LaunchViewController: UIViewController {
    @IBOutlet var blankView: UIView!
    @IBOutlet var onboardingView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        isFirstLaunch()
        showOnboarding ? onboarding() : main()
        onboardingCompleted ? skipOnboarding() : ()
    }
    
    @IBOutlet var launchWidthConstraint: NSLayoutConstraint!
    @IBOutlet var launchHeightConstraint: NSLayoutConstraint!
    @IBOutlet var launchTopConstraint: NSLayoutConstraint!
    
    func onboarding(){
        self.launchWidthConstraint.changeMultiplier(multiplier: 0.883761)
        self.launchHeightConstraint.changeMultiplier(multiplier: 0.550158)
        self.launchTopConstraint.constant = 146
        
        UIView.animate(withDuration: 1.0, delay: 0.5, animations: {
            self.blankView.layoutIfNeeded()
        }, completion: { (finished: Bool) in
            onboardingCompleted = true
            self.presentView(view: OnboardingWelcomeViewController(), animated: false, presentationStyle: .fullScreen, dismissPrevious: false)
        })
    }
    
    @IBOutlet var onboardingHeightConstraint: NSLayoutConstraint!
    @IBOutlet var onboardingWidthConstraint: NSLayoutConstraint!
    @IBOutlet var onboardingTopConstraint: NSLayoutConstraint!
    
    func skipOnboarding(){
        self.onboardingView.isHidden = false
        self.onboardingHeightConstraint.changeMultiplier(multiplier: 0.853795)
        self.onboardingWidthConstraint.changeMultiplier(multiplier: 1)
        self.onboardingTopConstraint.constant = 90
        
        UIView.animate(withDuration: 0.9, animations: {
            self.onboardingView.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }, completion: { (finished: Bool) in
            showOnboarding = false
            self.presentView(view: MainViewController(), animated: false, presentationStyle: .fullScreen, dismissPrevious: true)
        })
    }
    
    func main(){
        self.launchWidthConstraint.changeMultiplier(multiplier: 1)
        self.launchHeightConstraint.changeMultiplier(multiplier: 0.853)
        self.launchTopConstraint.constant = 90
        
        UIView.animate(withDuration: 0.9, animations: {
            self.blankView.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }, completion: { (finished: Bool) in
            self.presentView(view: MainViewController(), animated: false, presentationStyle: .fullScreen, dismissPrevious: true)
        })
    }
}
