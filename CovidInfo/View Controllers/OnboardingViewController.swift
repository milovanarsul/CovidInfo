//
//  OnboardingRenameViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 07.06.2022.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "GeneralOnboarding")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.dropShadow = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 6
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = signatureDarkBlue
        pageControl.currentPageIndicatorTintColor = signatureLightBlue
        pageControl.isHidden = true
        return pageControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegates.onboarding = self
        setup()
    }
    
    var containerViewWidthConstraint = NSLayoutConstraint()
    var containerViewHeightConstraint = NSLayoutConstraint()
    var containerViewVerticalConstraint = NSLayoutConstraint()
    
    func setup(){
        embed.onboardingViewController(parent: self, container: contentView)
        view.addSubviews(views: [backgroundImage, containerView])
        
        defaultConstraints(childView: backgroundImage, parentView: view)
        
        containerViewWidthConstraint = containerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.88)
        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: 493)
        containerViewVerticalConstraint = containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerViewVerticalConstraint,
            containerViewHeightConstraint,
            containerViewWidthConstraint
        ])
        
        containerView.addSubviews(views: [contentView, pageControl])
        
        let pageControlConstraints = Constraints(childView: pageControl, parentView: containerView, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 10)
        ])
        pageControlConstraints.addConstraints()
        
        let contentViewConstraints = Constraints(childView: contentView, parentView: containerView, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .top, multiplier: 1, constant: 0)
        ])
        contentViewConstraints.addConstraints()
        contentView.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: 10).isActive = true
    }
}

extension OnboardingViewController: OnboardingDelegate {
    func startTutorial() {
        contentView.isHidden = true
        delegates.onboardingPVC.nextPage!()
        containerViewHeightConstraint.constant = 717
        
        UIView.animate(withDuration: 0.5, animations: {
            self.containerView.layoutIfNeeded()
        }, completion: {(finished: Bool) in
            self.contentView.isHidden = false
            self.pageControl.isHidden = false
        })
        
    }
    
    func skipTutorial() {
        startTutorial()
        delegates.onboarding.pageControlVisibility(visibility: true)
        delegates.onboardingPVC.goToPage(pageIndex: 6, direction: .forward)
    }
    
    func setPageControl() {
        pageControl.currentPage += 1
    }
    
    func downloadData(dataRequest: DataRequest){
        delegates.onboarding.pageControlVisibility(visibility: true)
        delegates.onboardingPVC.goToPage(pageIndex: 8, direction: .forward)
        
        containerViewHeightConstraint.constant = 493
        UIView.animate(withDuration: 0.5, animations: {
            self.containerView.layoutIfNeeded()
        }, completion: {(finished: Bool) in
            delegates.onboardingDownload.downloadData(dataRequest: dataRequest)
        })
    }
    
    func goToMain(){
        contentView.isHidden = true
        
        containerViewWidthConstraint.changeMultiplier(multiplier: 1)
        containerViewHeightConstraint.constant = 740
        
        containerViewVerticalConstraint.isActive = false
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        UIView.animate(withDuration: 0.5, animations: {
            self.containerView.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }, completion: {(finished: Bool) in
            self.presentView(view: MainViewController(), animated: false, presentationStyle: .fullScreen, dismissPrevious: true)
            self.removeFromParent()
        })
    }
    
    func enrollCertifficate(){
        let modal = EnrollCertifficateViewController()
        modal.modalPresentationStyle = .formSheet
        
        if let sheet = modal.sheetPresentationController {
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 24
        }
        present(modal, animated: true, completion: nil)
    }
    
    func presentModal(view: UIView){
        let modal = UIViewController()
        modal.view = view
        
        if let sheet = modal.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 24
        }
        
        present(modal, animated: true, completion: nil)
    }
    
    func dismissModal(completion: @escaping (() -> Void)) {
        dismiss(animated: true, completion: completion)
    }
    
    func pageControlVisibility(visibility: Bool){
        pageControl.isHidden = visibility
    }
}
