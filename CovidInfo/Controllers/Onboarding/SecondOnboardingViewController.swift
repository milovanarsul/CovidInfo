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
    @IBOutlet weak var blankCard: UIView!
    @IBOutlet weak var secondCard: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startLottieAnimation(lottieAnimationView: self.lottieAnimationView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        secondStartupAnimation()
        self.view.layoutIfNeeded()
    }
    
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        
    }
    
    @IBOutlet weak var blankCardTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var blankCardBottomConstraint: NSLayoutConstraint!
    
    func secondStartupAnimation(){
        blankCardTopConstraint.constant = 30
        blankCardBottomConstraint.constant = 30
        
        UIView.animate(withDuration: 0.7, delay: 0.2, options: [], animations:{
            self.blankCard.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }, completion: { [self] (finished: Bool) in
            blankCard.isHidden = true
            secondCard.isHidden = false
        })
    }
}
