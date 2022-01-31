//
//  WelcomeOnboardingViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 29.01.2022.
//

import UIKit
import Lottie

class WelcomeOnboardingViewController: UIViewController {

    @IBOutlet weak var welcomeView: UIView!
    @IBOutlet weak var blankIconView: UIView!
    @IBOutlet var viewBackground: UIImageView!
    @IBOutlet var skipOnboarding: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        startUpAnimation()
        self.view.layoutIfNeeded()
    }
    
    @IBOutlet weak var blankIconViewLeadinConstraint: NSLayoutConstraint!
    @IBOutlet weak var blankIconViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var blankIconViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var blankIconViewBottomConstraint: NSLayoutConstraint!
    
    private func startUpAnimation(){
        self.blankIconViewLeadinConstraint.constant = 0
        self.blankIconViewTrailingConstraint.constant = 0
        self.blankIconViewTopConstraint.constant = 165
        self.blankIconViewBottomConstraint.constant = 175
        
        UIView.animate(withDuration: 0.9, delay: 0, options: [], animations: {
            self.blankIconView.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }, completion: { (finished: Bool) in
            self.welcomeView.isHidden = false
            self.blankIconView.isHidden = true
        })
    }
    
    @IBAction func omiteTutorialulPressed(_ sender: Any) {
        skipOnboardingAnimation()
    }
    
    @IBOutlet var skipOnboardingViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet var skipOnboardingViewTopConstraint: NSLayoutConstraint!
    
    private func skipOnboardingAnimation(){
        self.viewBackground.isHidden = true
        self.welcomeView.isHidden = true
        self.skipOnboarding.isHidden = false
        
        self.skipOnboardingViewBottomConstraint.constant = -3
        self.skipOnboardingViewTopConstraint.constant = 60
        
        UIView.animate(withDuration: 0.9, delay: 0, options: [], animations: {
            self.skipOnboarding.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }, completion: { (finished: Bool) in
            self.performSegue(withIdentifier: "onboardingSkipped", sender: nil)
        })
    }
}
