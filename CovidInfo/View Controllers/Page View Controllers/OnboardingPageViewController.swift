//
//  GeneralOnboardingPageViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 29.01.2022.
//

import UIKit

class OnboardingPageViewController: UIPageViewController{
    
    fileprivate var cards: [UIViewController] = []
    var laterButtonDelegate: OnboardingViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        createViewControllers()
        initialize(pages: cards)
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
        let onboardingCardView = OnboardingCards(labelText: labelText)
        onboardingCard.view = onboardingCardView
        return onboardingCard
    }
}

extension OnboardingPageViewController: UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = cards.firstIndex(of: viewController) else {return nil}
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
        
        if viewControllerIndex == 2{
            laterButtonDelegate.showEnrollCertificateButton(show: true)
        }
        
        if viewControllerIndex == 3{
            laterButtonDelegate.showCreateAccountButton(show: true)
        }
        
        return cards[nextIndex]
    }
}

extension OnboardingPageViewController: OnboardingPageViewControllerDelegate{
    func nextButtonIsTapped() {
        goToNextPage()
    }
}
