//
//  OnboardingWelcomeViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 13.01.2022.
//

import UIKit

class OnboardingWelcomeViewController: UIPageViewController {
    
    @IBAction func continueOnboardingButtonpPressed(_ sender: UIButton) {
        if let pageController = parent as? MainPageViewController {
            pageController.pushNext()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
