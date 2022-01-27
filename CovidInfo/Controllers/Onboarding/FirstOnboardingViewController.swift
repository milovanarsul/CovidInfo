//
//  FirstOnboardingViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 27.01.2022.
//

import UIKit

class FirstOnboardingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func nextButtonIsTapped(_ sender: Any) {
        if let pageController = parent as? OnboardingPageViewController {
                pageController.pushNext()
            }
    }
}
