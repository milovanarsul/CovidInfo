//
//  GeneralOnboardingViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 11.02.2022.
//

import UIKit
import Lottie

class GeneralOnboardingViewController: UIViewController {
    @IBOutlet var cv: UIView!
    @IBOutlet var topImage: UIImageView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var viewContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegates.onboardingSub = self
        let embed = EmbedView()
        embed.onboardingViewController(parent: self, container: self.viewContainer)
    }
    
    @IBOutlet var cvLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var cvHeightConstraint: NSLayoutConstraint!
    @IBOutlet var cvTopConstraint: NSLayoutConstraint!
}

extension GeneralOnboardingViewController: OnboardingSubDelegate{
    func finishOnboarding() {
        self.topImage.isHidden = true
        self.viewContainer.isHidden = true
        self.pageControl.isHidden = true
        
        cvLeadingConstraint.constant = 0
        cvHeightConstraint.changeMultiplier(multiplier: 0.853795)
        cvTopConstraint.constant = 90
        
        UIView.animate(withDuration: 0.9, animations: {
            self.cv.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }, completion: {(finished: Bool) in
            self.performSegue(withIdentifier: "onboardingFinished", sender: self)
        })
    }
    
    func setPageControl(){
        self.pageControl.currentPage += 1
    }
}
