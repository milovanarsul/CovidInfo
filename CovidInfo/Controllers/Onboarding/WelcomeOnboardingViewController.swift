//
//  WelcomeOnboardingViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 13.01.2022.
//

import UIKit

class WelcomeOnboardingViewController: UIViewController {
    
    @IBAction func continueOnboardingButtonpPressed(_ sender: UIButton) {
        if let pageController = parent as? MainPageViewController {
            pageController.pushNext()
        }
    }
    
    @IBAction func skipOnboardingButtonPressed(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
