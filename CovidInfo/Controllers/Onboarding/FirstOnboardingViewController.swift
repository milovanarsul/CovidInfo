//
//  FirstOnboardingViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 27.01.2022.
//

import UIKit

class FirstOnboardingViewController: UIViewController {
    @IBOutlet weak var welcomeView: InterfaceBuilderInspectables!
    @IBOutlet weak var blankIcon: InterfaceBuilderInspectables!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        startUpAnimation()
        self.view.layoutIfNeeded()
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        if let pageController = parent as? OnboardingPageViewController {
                pageController.pushNext()
        }
    }
    
    @IBOutlet weak var blankIconLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var blankIconTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var blankIconBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var blankIconTopConstraint: NSLayoutConstraint!
    
    func startUpAnimation(){
        self.blankIconLeadingConstraint.constant = 0
        self.blankIconTrailingConstraint.constant = 0
        self.blankIconBottomConstraint.constant = 150
        self.blankIconTopConstraint.constant = 150
        
        UIView.animate(withDuration: 10){
            self.blankIcon.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }
    }
}
