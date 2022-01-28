//
//  SecondOnboardingViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 27.01.2022.
//

import UIKit
import Lottie

class SecondOnboardingViewController: UIViewController {
    
    @IBOutlet weak var lottieAnimationView: AnimationView!
    @IBOutlet weak var contentCard: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startLottieAnimation(lottieAnimationView: self.lottieAnimationView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        secondStartupAnimation()
        self.view.layoutIfNeeded()
    }
    
    
    @IBOutlet weak var contentCardTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentCardBottomConstraint: NSLayoutConstraint!
    
    func secondStartupAnimation(){
        contentCardTopConstraint.constant = 20
        contentCardBottomConstraint.constant = 20
        
        UIView.animate(withDuration: 0.7, delay: 0.2, options: [], animations:{
            self.contentCard.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }, completion: {_ in
            self.contentCard.isHidden = false
        })
    }
}
