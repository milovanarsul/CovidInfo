//
//  GeneralOnboardingPageViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 29.01.2022.
//

import UIKit

class GeneralOnboardingPageViewController: UIPageViewController{
    
    fileprivate var cards: [UIViewController] = []
    var laterButtonDelegate: OnboardingViewControllerToOnboardingPageViewController!
    
    var currentIndex: Int {
        guard let currentViewController = viewControllers?.first else {return 0}
        return cards.firstIndex(of: currentViewController) ?? 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        createViewControllers()
        if let firstViewController = cards.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        
        disableSwipeGesture()
    }
    
    fileprivate func createViewControllers(){
        let onboardingData = onboardingDataArray
        
        for data in onboardingData{
            let viewController = createOnboardingCard(with: data.getLabelText())
            cards.append(viewController)
        }
    }
    
    fileprivate func createOnboardingCard(with labelText: String) -> UIViewController{
        let onboardingCard = UIViewController()
        let onboardingCardView = OnboardingCardsView(labelText: labelText)
        //onboardingCardView.generalOnboardingDelegate = self
        onboardingCard.view = onboardingCardView
        return onboardingCard
    }
}

extension GeneralOnboardingPageViewController: OnboardingPageViewControllerToOnboardingViewController{
    func nextButtonIsTapped() {
        goToNextPage()
    }
}

extension GeneralOnboardingPageViewController: UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = cards.firstIndex(of: viewController) else {return nil} //currentIndex
        
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {return nil}
        
        guard cards.count > previousIndex else {return nil}
        
        return cards[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = cards.firstIndex(of: viewController) else {return nil}
        
        let nextIndex = viewControllerIndex + 1
        guard cards.count != nextIndex else {return nil}
        
        guard cards.count > nextIndex else {return nil}
        
        //actions for delegates go here
        if viewControllerIndex == 2{
            laterButtonDelegate.showEnrollCertificateButton(show: true)
        }
        
        if viewControllerIndex == 3{
            laterButtonDelegate.showCreateAccountButton(show: true)
        }
    
        
        return cards[nextIndex]
    }
}

extension GeneralOnboardingPageViewController: UIPageViewControllerDelegate{
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let viewControllers = pageViewController.viewControllers else {return}
        guard let currentIndex = cards.firstIndex(of: viewControllers[0]) else {return}
        
        _ = currentIndex
    }
}
