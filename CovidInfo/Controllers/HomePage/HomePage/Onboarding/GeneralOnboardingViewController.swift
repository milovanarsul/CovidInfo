//
//  GeneralOnboardingViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 29.01.2022.
//

import UIKit

class GeneralOnboardingViewController: UIViewController {
    @IBOutlet weak var generalView: UIView!
    @IBOutlet weak var blankWelcomeView: UIView!
    @IBOutlet var laterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupAnimation()
        self.view.layoutIfNeeded()
    }
    
    @IBOutlet weak var blankWelcomeViewHeightConstraint: NSLayoutConstraint!
    
    private func setupAnimation(){
        blankWelcomeViewHeightConstraint.change(multiplier: 0.75)
        
        UIView.animate(withDuration: 0.7, delay: 0, options: [], animations: {
            self.blankWelcomeView.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }, completion: {(finished: Bool) in
            self.generalView.isHidden = false
            self.blankWelcomeView.isHidden = true
        })
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func laterButtonTapped(_ sender: Any) {
    }
    
}
