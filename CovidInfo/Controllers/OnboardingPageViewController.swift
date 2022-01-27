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
        let firstVC = storyboard.instantiateViewController(withIdentifier: "FirstStepVC")
        let secondVC = storyboard.instantiateViewController(withIdentifier: "SecondStepVC")
        return [firstVC, secondVC]
    }()

}
