//
//  GeneralOnboardingViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 11.02.2022.
//

import UIKit
import Lottie

class OnboardingViewController: UIViewController {
    
    lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "GeneralOnboarding")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.dropShadow = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        embed.onboardingViewController(parent: self, container: view)
        return view
    }()
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 4
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = signatureDarkBlue
        pageControl.currentPageIndicatorTintColor = signatureLightBlue
        return pageControl
    }()
    
    lazy var animationView: AnimationView = {
        let animationView = AnimationView()
        return animationView
    }()
    
    lazy var loadingAnimation: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        return activityIndicator
    }()
    
    lazy var loadingLabel: UILabel = {
        let label = UILabel()
        label.initialize(text: "Pregatim datele pentru tine", color: .label, font: boldFont(size: 12), alignment: .center, lines: 0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegates.onboardingSub = self
        setup()
    }
    
    var containerViewWidthConstraint = NSLayoutConstraint()
    var containerViewHeightConstraint = NSLayoutConstraint()
    var containerViewVerticalConstraint = NSLayoutConstraint()
    
    func setup(){
        view.addSubviews(views: [backgroundImage, containerView])
        containerView.addSubviews(views: [contentView, pageControl, animationView])
        
        defaultConstraints(childView: backgroundImage, parentView: view)
        
        containerViewVerticalConstraint = Constraint(childView: containerView, parentView: view, constraintType: .vertical, multiplier: 1, constant: 0).setConstraint()
        containerViewWidthConstraint = Constraint(childView: containerView, parentView: view, constraintType: .proportionalWidth, multiplier: onboardingWidth, constant: 0).setConstraint()
        containerViewHeightConstraint = Constraint(childView: containerView, parentView: view, constraintType: .proportionalHeight, multiplier: 0.8, constant: 0).setConstraint()
        NSLayoutConstraint.activate([Constraint(childView: containerView, parentView: view, constraintType: .horizontal, multiplier: 1, constant: 0).setConstraint(), containerViewVerticalConstraint, containerViewWidthConstraint, containerViewHeightConstraint])
        
        let animationViewConstraints = Constraints(childView: animationView, parentView: containerView, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .vertical, multiplier: 1, constant: -40),
            Constraint(constraintType: .proportionalHeight, multiplier: 0.35, constant: 0),
            Constraint(constraintType: .aspectRatio, multiplier: (1.0/1.0), constant: 0)
        ])
        animationViewConstraints.addConstraints()
        
        let pageControlConstraints = Constraints(childView: pageControl, parentView: containerView, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 10)
        ])
        pageControlConstraints.addConstraints()
        
        let contentViewConstraints = Constraints(childView: contentView, parentView: containerView, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0)
        ])
        contentViewConstraints.addConstraints()
        NSLayoutConstraint.activate([NSLayoutConstraint(item: contentView, attribute: .top, relatedBy: .equal, toItem: animationView, attribute: .bottom, multiplier: 1, constant: 30), NSLayoutConstraint(item: pageControl, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: 10)])
    }
    
    func awaitDataDownload(){
        removeViewsFromSuperView(views: [contentView, pageControl, animationView])
        
        containerView.addSubviews(views: [loadingAnimation, loadingLabel])
        
        let loadingAnimationConstraints = Constraints(childView: loadingAnimation, parentView: containerView, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .vertical, multiplier: 1, constant: -40),
            Constraint(constraintType: .proportionalHeight, multiplier: 0.35, constant: 0),
            Constraint(constraintType: .aspectRatio, multiplier: (1.0/1.0), constant: 0)
        ])
        loadingAnimationConstraints.addConstraints()
        
        containerView.addSubview(loadingLabel)
        NSLayoutConstraint.activate([
            loadingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingLabel.topAnchor.constraint(equalTo: loadingAnimation.bottomAnchor, constant: 10)
        ])
        
        loadingAnimation.startAnimating()
    }
    
    func finishDataDownload(){
        removeViewsFromSuperView(views: [loadingAnimation, loadingLabel])
        containerViewWidthConstraint.changeMultiplier(multiplier: 1)
        containerViewHeightConstraint.changeMultiplier(multiplier: homeHeight)
        containerView.removeConstraint(containerViewVerticalConstraint)
        NSLayoutConstraint.activate([Constraint(childView: containerView, parentView: view, constraintType: .bottom, multiplier: 1, constant: 0).setConstraint()])
        
        UIView.animate(withDuration: defaultAnimationDuration, animations: {
            self.contentView.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }, completion: {(finished: Bool) in
            self.presentView(view: MainViewController(), animated: false, presentationStyle: .fullScreen, dismissPrevious: true)
            self.removeFromParent()
        })
        
    }
}

extension OnboardingViewController: OnboardingSubDelegate{
    func finishOnboarding() {
        awaitDataDownload()
        DispatchQueue.main.async {
            parseCurrentData()
            parseHistoricalData()
            parseOldHistoricalData(json: .date2021)
            parseOldHistoricalData(json: .date2020)
            digi24(articleCount: 40)
            stiriOficiale()

            self.finishDataDownload()
            defaults.set(Date(), forKey: "lastRefresh")
        }
    }
    
    func setPageControl(){
        pageControl.currentPage += 1
    }
    
    func setupAnimation(animationName: String){
        animationView.animation = Animation.named(animationName)
        animationView.play()
    }
}
