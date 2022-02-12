//
//  LaunchViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 11.02.2022.
//

import UIKit

private var onboardingCompleted: Bool = true

class LaunchViewController: UIViewController {
    @IBOutlet var blankView: UIView!
    @IBOutlet var onboardingView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        onboardingCompleted ? finishOnboarding() : onboarding()
    }
    
    
    @IBOutlet var leadingConstraint: NSLayoutConstraint!
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var topConstraint: NSLayoutConstraint!
    
    func onboarding(){
        self.leadingConstraint.constant = 24
        self.heightConstraint.changeMultiplier(multiplier: 0.55)
        self.topConstraint.constant = 150
        
        UIView.animate(withDuration: 1.0, animations: {
            self.blankView.layoutIfNeeded()
            //self.view.layoutIfNeeded()
        }, completion: { (finished: Bool) in
            self.performSegue(withIdentifier: "toOnboarding", sender: self)
            onboardingCompleted = true
            self.blankView.isHidden = true
        })
    }
    
    
    @IBOutlet var onboardingLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var onboardingTrailingConstraint: NSLayoutConstraint!
    @IBOutlet var onboardingHeightConstraint: NSLayoutConstraint!
    @IBOutlet var onboardingTopConstraint: NSLayoutConstraint!
    
    func finishOnboarding(){
        self.onboardingView.isHidden = false
        self.onboardingLeadingConstraint.constant = 0
        self.onboardingTrailingConstraint.constant = 0
        self.onboardingHeightConstraint.changeMultiplier(multiplier: 0.853795)
        self.onboardingTopConstraint.constant = 90
        
        
        UIView.animate(withDuration: 0.9, animations: {
            self.onboardingView.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }, completion: { (finished: Bool) in
            self.performSegue(withIdentifier: "toMain", sender: self)
        })
    }
    
    func main(){
        print("called")
        self.leadingConstraint.constant = 0
        self.heightConstraint.changeMultiplier(multiplier: 0.853795)
        self.topConstraint.constant = 90
        
        UIView.animate(withDuration: 0.9, animations: {
            self.blankView.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }, completion: { (finished: Bool) in
            self.performSegue(withIdentifier: "toMain", sender: self)
        })
    }
}
