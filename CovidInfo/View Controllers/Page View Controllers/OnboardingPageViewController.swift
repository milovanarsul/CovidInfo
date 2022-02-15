//
//  OnboardingPageViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 11.02.2022.
//

import UIKit

class OnboardingPageViewController: UIPageViewController {
    
    fileprivate var pages: [UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        delegates.onboarding = self
        
        let pageViewControllerDataSource = PageViewControllerDataSource(pages: pages, pageController: .home)
        dataSource = pageViewControllerDataSource
        createViewControllers()
        initialize(pages: pages, scroll: true)
    }
    
    fileprivate func createViewControllers(){
        let onboardingData = onboardingDataArray
        
        for data in onboardingData{
            let viewController = createOnboardingCard(animationName: data.getLottieAnimation(), labelText: data.getLabelText(), modalNext: data.isModalNext)
            pages.append(viewController)
        }
    }
    
    fileprivate func createOnboardingCard(animationName: String, labelText: String, modalNext: Bool) -> UIViewController{
        let onboardingCardView = OnboardingCell(animationName: animationName, labelText: labelText, isModalNext: modalNext)
        return onboardingCardView
    }
}

extension OnboardingPageViewController: OnboardingDelegate{
    func getCurrentIndex() -> Int {
        return getCurrentIndex(views: pages)
    }
    
    func playAnimation() {}
    
    func nextPage() {
         let currentIndex = getCurrentIndex(views: pages)

         switch currentIndex{
         case 3:
             goToIndex(pageIndex: currentIndex + 2, direction: .forward, pages: pages)
         case 5:
             delegates.onboardingSub.finishOnboarding()
         default:
             goToIndex(pageIndex: currentIndex + 1, direction: .forward, pages: pages)
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
