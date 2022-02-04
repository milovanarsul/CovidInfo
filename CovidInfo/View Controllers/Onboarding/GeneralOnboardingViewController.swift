//
//  GeneralOnboardingViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 29.01.2022.
//

import UIKit
import Lottie

class GeneralOnboardingViewController: UIViewController {
    @IBOutlet weak var generalView: UIView!
    @IBOutlet weak var blankWelcomeView: UIView!
    @IBOutlet var pageController: UIPageControl!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var enrollCertificateButton: UIButton!
    @IBOutlet var createAccountButton: UIButton!
    @IBOutlet var containerView: UIView!
    @IBOutlet var animationView: UIView!
    @IBOutlet var onboardingFinished: UIView!
    @IBOutlet var parentView: UIView!
    
    var nextButtonOnboardingDelegate: OnboardingPageViewControllerDelegate!
    private var lottieAnimationView: AnimationView?
    
    var pageControllerIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let embed = EmbedView()
        embed.generalOnboardingPageViewController(parent: self, container: self.containerView)
        
        setupPageController()
        setupLottieAnimation(lottieAnimationName: onboardingDataArray[pageControllerIndex].getLottieAnimation())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupAnimation()
        self.view.layoutIfNeeded()
    }
    
    func setupLottieAnimation(lottieAnimationName: String){
        lottieAnimationView = .init(name: lottieAnimationName)
        lottieAnimationView!.frame = animationView.bounds
        lottieAnimationView!.contentMode = .scaleAspectFill
        lottieAnimationView!.loopMode = .playOnce
        lottieAnimationView!.animationSpeed = 0.5
        
        animationView.addSubview(lottieAnimationView!)
        lottieAnimationView!.play()
    }
    
    func setupPageController(){
        self.pageController.currentPage = self.pageControllerIndex
        self.pageController.numberOfPages = 5
    }
    
    @IBAction func delegateAction(_ sender: Any) {
        if pageControllerIndex < 4{
            nextButtonOnboardingDelegate.nextButtonIsTapped()
            self.pageControllerIndex += 1
            self.pageController.currentPage = self.pageControllerIndex
            lottieAnimationView?.removeFromSuperview()
            setupLottieAnimation(lottieAnimationName: onboardingDataArray[pageControllerIndex].getLottieAnimation())
        } else{
            setupFinsihedOnboardingAnimation()
        }
    }
    
    @IBOutlet weak var blankWelcomeViewHeightConstraint: NSLayoutConstraint!
    
    private func setupAnimation(){
        blankWelcomeViewHeightConstraint.changeMultiplier(multiplier: 0.75)
        
        UIView.animate(withDuration: 0.7, delay: 0, options: [], animations: {
            self.blankWelcomeView.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }, completion: {(finished: Bool) in
            self.generalView.isHidden = false
            self.blankWelcomeView.isHidden = true
        })
    }
    
    @IBOutlet var finishedOnboardingViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet var finishedOnboardingViewTopConstraint: NSLayoutConstraint!
    
    private func setupFinsihedOnboardingAnimation(){
        pageController.isHidden = true
        generalView.isHidden = true
        parentView.backgroundColor = .white
        onboardingFinished.isHidden = false
        
        finishedOnboardingViewBottomConstraint.constant = -3
        finishedOnboardingViewTopConstraint.constant = 90
        
        UIView.animate(withDuration: 0.9, delay: 0, options: [], animations: {
            self.onboardingFinished.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }, completion: { (finished: Bool) in
            self.performSegue(withIdentifier: "onboardingComplete", sender: nil)
        })
    }
}

extension GeneralOnboardingViewController: OnboardingViewControllerDelegate{
    func showEnrollCertificateButton(show: Bool) {
        self.createAccountButton.isHidden = show
        self.enrollCertificateButton.isHidden = !show
        self.nextButton.setAttributedTitle(changeButtonTitle(title: "Mai tarziu", font: "IBMPlexSans-Bold", fontSize: 14, color: UIColor.white), for: .normal)
    }
    
    func showCreateAccountButton(show: Bool) {
        self.enrollCertificateButton.isHidden = show
        self.createAccountButton.isHidden = !show
        self.nextButton.setAttributedTitle(changeButtonTitle(title: "Mai tarziu", font: "IBMPlexSans-Bold", fontSize: 14, color: UIColor.white), for: .normal)
    }
}

