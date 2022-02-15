//
//  LaunchViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 11.02.2022.
//

import UIKit

private var showOnboarding: Bool = false //control onboarding
private var onboardingCompleted: Bool = false

/*
 onboarding() - start onboarding experience if onboarding is enabled
 main() - go to MainViewController if onboarding is disabled
 finishOnboarding() - go to MainViewController if onboarding is skipped or finished
*/

class LaunchViewController: UIViewController {
    @IBOutlet var blankView: UIView!
    @IBOutlet var onboardingView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if OnboardingManager.shared.isFirstLaunch{
            showOnboarding = true
            OnboardingManager.shared.isFirstLaunch = true
        }
        
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
            self.performSegue(withIdentifier: "toOnboarding", sender: self)
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
            self.performSegue(withIdentifier: "toMain", sender: self)
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
            
            self.performSegue(withIdentifier: "toMain", sender: self)
        })
    }
}
