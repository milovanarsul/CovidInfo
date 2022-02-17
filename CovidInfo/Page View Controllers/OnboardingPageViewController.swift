//
//  OnboardingPageViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 11.02.2022.
//

import UIKit

class OnboardingPageViewController: UIPageViewController {
    
    var pages: [UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        delegates.onboarding = self
        
        let pageViewControllerDataSource = PageViewControllerDataSource(pages: pages, pageController: .home)
        dataSource = pageViewControllerDataSource
        createViewControllers()
        initialize(pages: pages, scroll: true)
        
        if getCurrentIndex(views: pages) == 0{
            delegates.onboardingSub.setupAnimation(animationName: "onboarding1")
        }
    }
    
    fileprivate func createViewControllers(){
        let onboardingData = onboardingDataArray
        
        for data in onboardingData{
            let viewController = createOnboardingCard(labelText: data.getLabelText(), modalNext: data.isModalNext)
            pages.append(viewController)
        }
    }
    
    fileprivate func createOnboardingCard(labelText: String, modalNext: Bool) -> UIViewController{
        let onboardingCardView = OnboardingCell(labelText: labelText, isModalNext: modalNext)
        return onboardingCardView
    }
}

extension OnboardingPageViewController: OnboardingDelegate{
    func getCurrentIndex() -> Int {
        return getCurrentIndex(views: pages)
    }
    
    func nextPage() {
         let currentIndex = getCurrentIndex(views: pages)

         switch currentIndex{
         case 3:
             goToIndex(pageIndex: currentIndex + 2, direction: .forward, pages: pages)
             delegates.onboardingSub.setupAnimation(animationName: onboardingDataArray[currentIndex + 2].getLottieAnimation())
         case 5:
             delegates.onboardingSub.finishOnboarding()
         default:
             goToIndex(pageIndex: currentIndex + 1, direction: .forward, pages: pages)
             delegates.onboardingSub.setupAnimation(animationName: onboardingDataArray[currentIndex + 1].getLottieAnimation())
         }
        
        delegates.onboardingSub.setPageControl()
    }
    
    func modal(){
        let modal = UIViewController()
        modal.view = OnboardingModal()
        modal.isModalInPresentation = true
        present(modal, animated: true, completion: nil)
    }
    
    func dismissModal(){
        dismiss(animated: true, completion: {
            self.nextPage()
        })
    }
}
