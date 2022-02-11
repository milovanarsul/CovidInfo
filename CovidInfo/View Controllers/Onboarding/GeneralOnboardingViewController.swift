//
//  GeneralOnboardingViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 11.02.2022.
//

import UIKit

class GeneralOnboardingViewController: UIViewController {
    @IBOutlet var viewContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegates.onboardingSubDelegate = self
        
        let embed = EmbedView()
        embed.onboardingViewController(parent: self, container: self.viewContainer)
    }
}

extension GeneralOnboardingViewController: OnboardingSubDelegate{
    func tabBarVisibility(tabBarVisibility: TabBarVisibility) {}
    
    func finishOnboarding() {
        performSegue(withIdentifier: "onboardingFinished", sender: self)
    }
}
