//
//  Fifth-FirstOnboardingViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 27.01.2022.
//

import UIKit
import Lottie

class Fifth_FirstOnboardingViewController: UIViewController {

    @IBOutlet weak var lottieAnimationView: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startLottieAnimation(lottieAnimationView: self.lottieAnimationView)
    }
}