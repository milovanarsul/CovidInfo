//
//  GeneralOnboardingPageViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 29.01.2022.
//

import UIKit

class GeneralOnboardingPageViewController: UIPageViewController, UIPageViewControllerDataSource{
    
    fileprivate var cards: [UIViewController] = []
    
    var currentIndex: Int {
        guard let currentViewController = viewControllers?.first else {return 0}
        return cards.firstIndex(of: currentViewController) ?? 0
    }
    
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
    
    func presentationCount(for _: UIPageViewController) -> Int {
            return cards.count
    }
        
    func presentationIndex(for _: UIPageViewController) -> Int {
        guard
            let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = cards.firstIndex(of: firstViewController) else {return 0}
        
        return firstViewControllerIndex
    }
    
    fileprivate func createOnboardingCard(with lottieAnimationName: String, with labelText: String, isLaterButtonEnabled: Bool) -> UIViewController{
        let onboardingCard = UIViewController()
        let onboardingCardView = OnboardingCardsView(lottieAnimationName: lottieAnimationName, labelText: labelText, isLaterButtonEnabled: isLaterButtonEnabled)
        onboardingCard.view = onboardingCardView
        return onboardingCard
    }
    
    let enrollCertificateButton = UIButton()
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = cards.firstIndex(of: viewController) else {return nil} //currentIndex
        
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {return nil}
        
        guard cards.count > previousIndex else {return nil}
        
        return cards[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let generalOnboardingViewController = GeneralOnboardingViewController()
        guard let viewControllerIndex = cards.firstIndex(of: viewController) else {return nil}
        
        let nextIndex = viewControllerIndex + 1
        guard cards.count != nextIndex else {return nil}
        
        guard cards.count > nextIndex else {return nil}
        
        
        return cards[nextIndex]
    }
}
