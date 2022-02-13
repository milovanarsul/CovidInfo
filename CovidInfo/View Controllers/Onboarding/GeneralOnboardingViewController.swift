//
//  GeneralOnboardingViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 11.02.2022.
//

import UIKit
import Lottie

class GeneralOnboardingViewController: UIViewController {
    @IBOutlet var viewContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegates.onboardingSub = self
        
        let embed = EmbedView()
        embed.onboardingViewController(parent: self, container: self.viewContainer)
    }
}

extension GeneralOnboardingViewController: OnboardingSubDelegate{
    func finishOnboarding() {
        performSegue(withIdentifier: "onboardingFinished", sender: self)
    }
}
