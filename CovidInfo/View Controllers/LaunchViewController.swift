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
        
        #if targetEnvironment(simulator)
            defaults.set(true, forKey: "certifficateEnrolled")
        #endif
    }
    
    override func viewWillAppear(_ animated: Bool) {
        isFirstLaunch()
        showOnboarding ? onboarding() : main()
        onboardingCompleted ? skipOnboarding() : ()
    }
    
    @IBOutlet weak var launchWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var launchHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var launchTopConstraint: NSLayoutConstraint!
    
    func onboarding(){
        self.launchWidthConstraint.changeMultiplier(multiplier: onboardingWidth)
        self.launchHeightConstraint.changeMultiplier(multiplier: onboardingHeight)
        self.launchTopConstraint.constant = 146
        
        UIView.animate(withDuration: 1.0, delay: 0.5, animations: {
            self.blankView.layoutIfNeeded()
        }, completion: { (finished: Bool) in
            onboardingCompleted = true
            self.presentView(view: OnboardingWelcomeViewController(), animated: false, presentationStyle: .fullScreen, dismissPrevious: false)
        })
    }
    
    @IBOutlet weak var onboardingHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var onboardingWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var onboardingTopConstraint: NSLayoutConstraint!
    
    func skipOnboarding(){
        self.onboardingView.isHidden = false
        animateConstraints(constraints: [(onboardingHeightConstraint, homeHeight, .multiplier), (onboardingWidthConstraint, 1, .multiplier), (onboardingTopConstraint, homeTopConstraint, .constant)])
        
        UIView.animate(withDuration: defaultAnimationDuration, animations: {
            self.onboardingView.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }, completion: { (finished: Bool) in
            showOnboarding = false
            self.presentView(view: MainViewController(), animated: false, presentationStyle: .fullScreen, dismissPrevious: true)
        })
    }
    
    func main(){
        animateConstraints(constraints: [(launchWidthConstraint, 1, .multiplier),(launchHeightConstraint, homeHeight, .multiplier), (launchTopConstraint, homeTopConstraint, .constant)])
        
        UIView.animate(withDuration: defaultAnimationDuration, animations: {
            self.blankView.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }, completion: { (finished: Bool) in
            self.presentView(view: MainViewController(), animated: false, presentationStyle: .fullScreen, dismissPrevious: true)
        })
    }
}
