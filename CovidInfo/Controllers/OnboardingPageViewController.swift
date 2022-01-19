//
//  OnboardingPageViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 13.01.2022.
//

import UIKit

class OnboardingPageViewController: UIPageViewController {
    
    private var currentIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewControllers([onboardingViewControllers[0]], direction: .forward, animated: false, completion: nil)
    }
    
    func nextVC() {
        if currentIndex + 1 < onboardingViewControllers.count {
          self.setViewControllers([self.onboardingViewControllers[self.currentIndex + 1]], direction: .forward, animated: true, completion: nil)
            currentIndex += 1
        }
    }
    
    private var onboardingViewControllers: [UIViewController] = {
        let storyboard = UIStoryboard.onboarding
        let firstVC = storyboard.instantiateViewController(withIdentifier: "FirstStepVC")
        let secondVC = storyboard.instantiateViewController(withIdentifier: "SecondStepVC")
        let thirdVC = storyboard.instantiateViewController(withIdentifier: "ThirdStepVC")
        return [firstVC, secondVC, thirdVC]
    }()
    
}
