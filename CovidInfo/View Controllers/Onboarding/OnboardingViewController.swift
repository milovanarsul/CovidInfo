//
//  GeneralOnboardingViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 11.02.2022.
//

import UIKit
import Lottie

class OnboardingViewController: UIViewController {
    @IBOutlet var cv: UIView!
    @IBOutlet var topImage: UIImageView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var viewContainer: UIView!
    @IBOutlet var animationView: AnimationView!
    
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

extension OnboardingViewController: OnboardingSubDelegate{
    func finishOnboarding() {
        self.animationView.isHidden = true
        self.topImage.isHidden = true
        self.viewContainer.isHidden = true
        self.pageControl.isHidden = true
        
        cvLeadingConstraint.constant = 0
        cvHeightConstraint.changeMultiplier(multiplier: homeHeight)
        cvTopConstraint.constant = homeTopConstraint
        
        UIView.animate(withDuration: defaultAnimationDuration, animations: {
            self.cv.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }, completion: {(finished: Bool) in
            self.presentView(view: MainViewController(), animated: false, presentationStyle: .fullScreen, dismissPrevious: true)
            self.removeFromParent()
        })
    }
    
    func setPageControl(){
        self.pageControl.currentPage += 1
    }
    
    func setupAnimation(animationName: String){
        self.animationView.animation = Animation.named(animationName)
        self.animationView.play()
    }
}
