//
//  GeneralOnboardingPageViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 29.01.2022.
//

import UIKit

class OnboardingPageViewController: UIPageViewController{
    
    fileprivate var cards: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pageViewControllerDataSource = PageViewControllerDataSource(pages: cards, pageController: .onboarding)
        dataSource = pageViewControllerDataSource
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

extension OnboardingPageViewController: OnboardingDelegate{
    func showEnrollCertificateButton(show: Bool) {}
    
    func showCreateAccountButton(show: Bool) {}
    
    func nextButtonIsTapped() {
        goToNextPage()
    }
}
