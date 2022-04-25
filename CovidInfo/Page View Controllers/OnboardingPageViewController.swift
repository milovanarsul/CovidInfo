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
        
        let pageViewControllerDataSource = PageViewControllerDataSource(pages: pages)
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
        let onboardingCardViewController = UIViewController()
        let view = OnboardingCell()
        view.setup(labelText: labelText, isModalNext: modalNext)
        onboardingCardViewController.view = view
        return onboardingCardViewController
    }
}

extension OnboardingPageViewController: OnboardingDelegate{
    func getCurrentIndex() -> Int {
        return getCurrentIndex(views: pages)
    }
    
    func nextPage() {
         let currentIndex = getCurrentIndex(views: pages)
        
        switch currentIndex {
        case 3:
            delegates.onboardingSub.finishOnboarding()
        default:
            goToIndex(pageIndex: currentIndex + 1, direction: .forward, pages: pages)
            delegates.onboardingSub.setupAnimation(animationName: onboardingDataArray[currentIndex + 1].getLottieAnimation())
        }
        
        delegates.onboardingSub.setPageControl()
    }
    
    func modalView(){
        let modal = EnrollCertifficateViewController()
        modal.modalPresentationStyle = .formSheet
        
        if let sheet = modal.sheetPresentationController {
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 24
        }
        present(modal, animated: true, completion: nil)
    }
    
    func dismissModal(){
        dismiss(animated: true, completion: {
            self.nextPage()
        })
    }
}

extension OnboardingPageViewController: UIAdaptivePresentationControllerDelegate {
    public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        nextPage()
        delegates.enrollCertifficate.stopCapture()
    }
}
