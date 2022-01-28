//
//  MainViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 27.01.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        
        if OnboardingManager.shared.isFirstLaunch {
            performSegue(withIdentifier: "toOnboarding", sender: nil)
            OnboardingManager.shared.isFirstLaunch = true
        } else {
            performSegue(withIdentifier: "toHomePage", sender: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
