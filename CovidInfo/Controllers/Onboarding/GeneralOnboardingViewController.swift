//
//  GeneralOnboardingViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 13.01.2022.
//

import UIKit
import Lottie

class GeneralOnboardingViewController: UIViewController {

    @IBOutlet var lottieAnimationView: AnimationView!
    @IBOutlet weak var animationLabel: UILabel!
    @IBOutlet weak var nextOnboardingButton: UIButton!
    @IBOutlet weak var skipCurrentOnboardingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func createGeneralOnboardingViewFromData(generalOnboardingData: GeneralOnboardingData){
        
        lottieAnimationView = .init(name: generalOnboardingData.lottieAnimationName!)
        animationLabel.text = generalOnboardingData.animationLabel!
        
        if generalOnboardingData.hasSkipButton{
            skipCurrentOnboardingButton.alpha = 1
        } else {
            skipCurrentOnboardingButton.alpha = 0
        }
    }
    
    @IBAction func nextOnboardingButtonPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func skipCurrentOnboardingButtonPressed(_ sender: Any) {
        
    }
}
