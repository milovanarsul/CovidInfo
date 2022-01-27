//
//  FourthOnboardingViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 27.01.2022.
//

import UIKit
import Lottie

class FourthOnboardingViewController: UIViewController {

    @IBOutlet weak var lottieAnimationView: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startLottieAnimation(lottieAnimationView: self.lottieAnimationView)
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        if let pageController = parent as? OnboardingPageViewController {
                pageController.pushNext()
        }
    }
}
