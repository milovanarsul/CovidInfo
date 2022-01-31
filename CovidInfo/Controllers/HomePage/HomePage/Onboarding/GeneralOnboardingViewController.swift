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
    
    var nextButtonOnboardingDelegate: OnboardingPageViewControllerToOnboardingViewController!
    var pageControllerIndex = 0
    private var lottieAnimationView: AnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let embedPageViewController = OnboardingViewControllersEmbedder()
        embedPageViewController.embed(withIdentifier: "generalOnboardingPageViewController", parent: self, container: self.containerView, completion: nil)
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
            performSegue(withIdentifier: "onboardingComplete", sender: nil)
        }
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
            //self.pageController.isHidden = false
        })
    }
    
    let changedTitle = NSMutableAttributedString(string: "Mai tarziu", attributes: [
        NSMutableAttributedString.Key.font: UIFont(name: "IBMPLexSans-Bold", size: 14) as Any,
        NSMutableAttributedString.Key.foregroundColor: UIColor.white
    ])
}

extension GeneralOnboardingViewController: OnboardingViewControllerToOnboardingPageViewController{
    func showEnrollCertificateButton(show: Bool) {
        self.createAccountButton.isHidden = show
        self.enrollCertificateButton.isHidden = !show
        self.nextButton.setAttributedTitle(changedTitle, for: .normal)
    }
    
    func showCreateAccountButton(show: Bool) {
        self.enrollCertificateButton.isHidden = show
        self.createAccountButton.isHidden = !show
        self.nextButton.setAttributedTitle(changedTitle, for: .normal)
    }
    
    func test(){
        print("Delegate works!")
    }
}

