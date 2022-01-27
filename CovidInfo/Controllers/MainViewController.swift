//
//  MainViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 27.01.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        
        performSegue(withIdentifier: "toOnboarding", sender: nil)
        OnboardingManager.shared.isFirstLaunch = true
        
        /*
        if LandscapeManager.shared.isFirstLaunch {
            performSegue(withIdentifier: "toOnboarding", sender: nil)
            LandscapeManager.shared.isFirstLaunch = true
        } else {
            performSegue(withIdentifier: "toMain", sender: nil)
        }
        */
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
