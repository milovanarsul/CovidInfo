//
//  OnboardingPageViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 27.01.2022.
//

import UIKit

class OnboardingPageViewController: UIPageViewController {
    
    private var currentIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewControllers([viewControllerList[0]], direction: .forward, animated: false, completion: nil)
    }
    
    func pushNext() {
        if currentIndex + 1 < viewControllerList.count {
          self.setViewControllers([self.viewControllerList[self.currentIndex + 1]], direction: .forward, animated: true, completion: nil)
            currentIndex += 1
        }
    }
    
    private var viewControllerList: [UIViewController] = {
        let storyboard = UIStoryboard.onboarding
        let firstOnboarding = storyboard.instantiateViewController(withIdentifier: "FirstOnboarding")
        let secondOnboarding = storyboard.instantiateViewController(withIdentifier: "SecondOnboarding")
        let thirdOnboarding = storyboard.instantiateViewController(withIdentifier: "ThirdOnboarding")
        let fourthOnboarding = storyboard.instantiateViewController(withIdentifier: "FourthOnboarding")
        let fifthOnboarding = storyboard.instantiateViewController(withIdentifier: "FifthOnboarding")
        let sixthOnboarding = storyboard.instantiateViewController(withIdentifier: "SixthOnboarding")
        
        return [firstOnboarding, secondOnboarding, thirdOnboarding, fourthOnboarding, fifthOnboarding, sixthOnboarding]
    }()

}
