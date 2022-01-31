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
    @IBOutlet var pageController: UIPageControl!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var enrollCertificateButton: UIButton!
    @IBOutlet var createAccountButton: UIButton!
    @IBOutlet var containerView: UIView!
    
    var nextButtonOnboardingDelegate: OnboardingPageViewControllerToOnboardingViewController!
    var lottieAnimationDelegate: LottieAnimationDelegate!
    
    var pageControllerIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let embedPageViewController = OnboardingViewControllersEmbedder()
        embedPageViewController.embed(withIdentifier: "generalOnboardingPageViewController", parent: self, container: self.containerView, completion: nil)
        setupPageController()
        //lottieAnimationDelegate.startAnimation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupAnimation()
        self.view.layoutIfNeeded()
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
        })
    }
}

extension GeneralOnboardingViewController: OnboardingViewControllerToOnboardingPageViewController{
    func showEnrollCertificateButton(show: Bool) {
        self.createAccountButton.isHidden = show
        self.enrollCertificateButton.isHidden = !show
        //self.nextButton.titleLabel?.text = "Mai tarziu"
        self.nextButton.setTitle("Mai tarziu", for: .normal)
    }
    
    func showCreateAccountButton(show: Bool) {
        self.enrollCertificateButton.isHidden = show
        self.createAccountButton.isHidden = !show
        //self.nextButton.titleLabel?.text = "Mai tarziu"
        self.nextButton.setTitle("Mai tarziu", for: .normal)
    }
    
    func test(){
        print("Delegate works!")
    }
}

