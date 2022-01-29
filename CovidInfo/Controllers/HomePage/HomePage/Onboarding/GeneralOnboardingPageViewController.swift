//
//  GeneralOnboardingPageViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 29.01.2022.
//

import UIKit

class GeneralOnboardingPageViewController: UIPageViewController, UIPageViewControllerDataSource{
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = cards.firstIndex(of: viewController) else {return nil}
        
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {return cards.last}
        
        guard cards.count > previousIndex else {return nil}
        
        return cards[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = cards.firstIndex(of: viewController) else {return nil}
        
        let nextIndex = viewControllerIndex + 1
        guard cards.count != nextIndex else {return nil}
        
        guard cards.count > nextIndex else {return nil}
        
        return cards[nextIndex]
    }
    
    func nextCard(){
        
    }
    
    fileprivate var cards: [UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        createViewControllers()
        if let firstViewController = cards.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        
    }
    
    fileprivate func createViewControllers(){
        let onboardingData = onboardingDataArray
        
        for data in onboardingData{
            let viewController = createOnboardingCard(with: data.getLottieAnimation(), with: data.getLabelText(), isLaterButtonEnabled: data.getIsLaterButtonEnabled())
            cards.append(viewController)
        }
    }
    
    fileprivate func createOnboardingCard(with lottieAnimationName: String, with labelText: String, isLaterButtonEnabled: Bool) -> UIViewController{
        let onboardingCard = UIViewController()
        onboardingCard.view = OnboardingCardsView(lottieAnimationName: lottieAnimationName, labelText: labelText, isLaterButtonEnabled: isLaterButtonEnabled)
        
        return onboardingCard
    }
}
