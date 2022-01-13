//
//  ConciergeViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 13.01.2022.
//

import UIKit

class ConciergeViewController: UIPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if LandscapeManager.shared.isFirstLaunch {
            performSegue(withIdentifier: "toOnboarding", sender: nil)
            LandscapeManager.shared.isFirstLaunch = true
        } else {
            performSegue(withIdentifier: "toMain", sender: nil)
        }
    }
}

extension UIStoryboard {
    static let onboarding = UIStoryboard(name: "Onboarding", bundle: nil)
    static let main = UIStoryboard(name: "Main", bundle: nil)
}
