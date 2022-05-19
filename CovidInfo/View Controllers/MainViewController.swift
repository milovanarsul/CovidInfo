//
//  MainViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 27.01.2022.
//

import UIKit
import Lottie
import BetterSegmentedControl

class MainViewController: UIViewController {
    
    lazy var navigationBar: UIView = {
        let view = CustomNavigationBar()
        view.setup()
        delegates.navigationBar = view
        view.backgroundColor = .white
        return view
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.dropShadow = true
        CovidInfo.embed.mainPageViewController(parent: self, container: view)
        return view
    }()
    
    lazy var certifficateButton: UIButton = {
        let button = UIButton()
        button.initialize(title: "Certificatul tau", titleColor: .white, cornerRadius: 24, font: boldFont(size: 14), backgroundColor: signatureDarkBlue, contentInsets: NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20), image: UIImage(systemName: "qrcode.viewfinder"))
        button.addTarget(self, action: #selector(certifficateButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var tabBar: UIView = {
        let view = CustomTabBar()
        view.setup()
        view.backgroundColor = .white
        view.dropShadow = true
        view.cornerRadius = 10
        return view
    }()
    
    lazy var tabBarExtension: UIView = {
        let view = TabBarExtension()
        view.setup()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var countryPicker: UIView = {
        let view = UIView()
        embed.countryPicker(parent: self, container: view)
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setup()
        tabAnimation(visibility: .show)
    }
    
    var tabBarBottomConstraint = NSLayoutConstraint()
    var tabBarHeightConstraint = NSLayoutConstraint()
    var tabBarWidthConstraint = NSLayoutConstraint()
    var certifficateButtonVerticalConstraint = NSLayoutConstraint()
    var navigationBarTopConstraint = NSLayoutConstraint()
    var contentViewTopConstraint = NSLayoutConstraint()
    
    func setup(){
        
        view.backgroundColor = .white
        view.addSubviews(views: [navigationBar, contentView, certifficateButton, tabBar])
        
        let navigationBarConstraints = Constraints(childView: navigationBar, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .height, multiplier: 1, constant: 90),
        ])
        navigationBarConstraints.addConstraints()
        navigationBarTopConstraint = NSLayoutConstraint(item: navigationBar, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([navigationBarTopConstraint])
        
        view.addSubview(countryPicker)
        view.sendSubviewToBack(countryPicker)
        
        let countryPickerConstraints = Constraints(childView: countryPicker, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 0)
        ])
        countryPickerConstraints.addConstraints()
        NSLayoutConstraint.activate([countryPicker.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 5)])
        
        let contentViewConstraints = Constraints(childView: contentView, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 0)
        ])
        contentViewConstraints.addConstraints()
        contentViewTopConstraint = NSLayoutConstraint(item: contentView, attribute: .top, relatedBy: .equal, toItem: navigationBar, attribute: .bottom, multiplier: 1, constant: 5)
        NSLayoutConstraint.activate([contentViewTopConstraint])
        
        let tabBarConstraints = Constraints(childView: tabBar, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0)
        ])
        tabBarConstraints.addConstraints()
        
        tabBarHeightConstraint = Constraint(childView: tabBar, parentView: view, constraintType: .height, multiplier: 1, constant: 50).setConstraint()
        tabBarWidthConstraint = Constraint(childView: tabBar, parentView: view, constraintType: .proportionalWidth, multiplier: 0.85, constant: 0).setConstraint()
        tabBarBottomConstraint = Constraint(childView: tabBar, parentView: view, constraintType: .bottom, multiplier: 1, constant: -100).setConstraint()
        NSLayoutConstraint.activate([tabBarWidthConstraint,tabBarHeightConstraint,tabBarBottomConstraint])
        
        certifficateButtonVerticalConstraint = NSLayoutConstraint(item: tabBar, attribute: .top, relatedBy: .equal, toItem: certifficateButton, attribute: .bottom, multiplier: 1, constant: -45)
        NSLayoutConstraint.activate([Constraint(childView: certifficateButton, parentView: view, constraintType: .horizontal, multiplier: 1, constant: 0).setConstraint(), certifficateButtonVerticalConstraint])
    }
    
    var tabBarExtensionBottomConstraint = NSLayoutConstraint()
    
    func tabBarExtensionSetup(){
        view.insertSubview(tabBarExtension, belowSubview: tabBar)
        
        tabBarExtensionBottomConstraint = NSLayoutConstraint(item: tabBar, attribute: .top, relatedBy: .equal, toItem: tabBarExtension, attribute: .bottom, multiplier: 1, constant: -44)
        NSLayoutConstraint.activate([tabBarExtensionBottomConstraint, Constraint(childView: tabBarExtension, parentView: view, constraintType: .horizontal, multiplier: 1, constant: 0).setConstraint(), NSLayoutConstraint(item: tabBarExtension, attribute: .width, relatedBy: .equal, toItem: tabBar, attribute: .width, multiplier: 1, constant: 0), Constraint(childView: tabBarExtension, parentView: view, constraintType: .height, multiplier: 1, constant: 45).setConstraint()])
    }
    
    func tabBarExtensionAnimation(visibility: ViewVisibility){
        switch visibility {
        case .show:
            tabBarExtensionBottomConstraint.constant = -7
        case .hide:
            tabBarExtensionBottomConstraint.constant = -44
        }
        
        UIView.animate(withDuration: 0.5, animations: {
        }, completion: {(finished: Bool) in
            self.view.bringSubviewToFront(self.tabBarExtension)
            if visibility == .hide{
                self.tabBarExtension.removeFromSuperview()
            }
        })
    }
    
    func tabAnimation(visibility: ViewVisibility){
        tabBarVisibility(tabBarVisibility: visibility)
        certifficateButtonAnimation(visibility: visibility)
    }
    
    @objc func certifficateButtonTapped(_ sender: UIButton) {
        defaults.bool(forKey: "certifficateEnrolled") ? certifficateModal() : enrollCertifficate()
    }
    
    var scrollViewScrollUp: Bool = false
}

extension MainViewController: MainDelegate{
    func animateContentView(size: CGFloat){
        contentViewTopConstraint.constant = size
        
        UIView.animate(withDuration: 0.4, animations: {
            self.contentView.layoutIfNeeded()
            self.view.layoutIfNeeded()
        })
    }
    
    func tabBarExtension(visibility: ViewVisibility){
        tabBarExtensionSetup()
        tabBarExtensionAnimation(visibility: visibility)
        
        if visibility == .hide {
            tabBarExtension.removeFromSuperview()
        }
    }
    
    func certifficateButtonAnimation(visibility: ViewVisibility){
        switch visibility {
        case .show:
            certifficateButtonVerticalConstraint.constant = 10
        case .hide:
            certifficateButtonVerticalConstraint.constant = -45
        }
        
        UIView.animate(withDuration: 0.6, animations: {
            self.certifficateButton.layoutIfNeeded()
        })
    }
    
    func tabBarVisibility(tabBarVisibility: ViewVisibility) {
        switch tabBarVisibility{
        case .hide:
            self.tabBarBottomConstraint.constant = -100
        case .show:
            self.tabBarBottomConstraint.constant = 30
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.tabBar.layoutIfNeeded()
        })
    }
    
    func certifficateModal(){
        let modal = UIViewController()
        let view = CertifficateView()
        view.setup()
        modal.view = view
        
        if let sheet = modal.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 24
        }
        present(modal, animated: true, completion: nil)
    }
    
    func enrollCertifficate(){
        let modal = EnrollCertifficateViewController()
        modal.modalPresentationStyle = .formSheet
        modal.transitioningDelegate = self
        
        if let sheet = modal.sheetPresentationController {
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 24
        }
        present(modal, animated: true, completion: nil)
    }
    
    func dimissModal(completion: @escaping (() -> Void)) {
        dismiss(animated: true, completion: completion)
    }
    
    func updateCertifficateButton(){
        self.certifficateButton.initialize(title: defaults.bool(forKey: "certifficateEnrolled") ? "Certificatul tau" : "Inroleaza certificat", titleColor: .white, cornerRadius: 24, font: boldFont(size: 14), backgroundColor: defaults.bool(forKey: "certifficateEnrolled") ? signatureDarkBlue : .red, contentInsets: NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20), image: UIImage(systemName: "qrcode.viewfinder"))
    }
    
    func scrollAnimation(size: CGFloat){
        let scrollLengthForTabBarExtension = size/10
        
        if scrollLengthForTabBarExtension < 44 && scrollLengthForTabBarExtension > 6 {
            tabBarExtensionBottomConstraint.constant = -scrollLengthForTabBarExtension
            view.bringSubviewToFront(tabBar)
            certifficateButton.isHidden = true
        } else if scrollLengthForTabBarExtension < 5 {
            tabBarExtensionBottomConstraint.constant = -7
            view.bringSubviewToFront(tabBarExtension)
            certifficateButton.isHidden = false
        }
        
        if scrollLengthForTabBarExtension == 43 {
            tabBarExtension.isHidden = true
        } else{
            tabBarExtension.isHidden = false
        }
        
        if scrollLengthForTabBarExtension > 47{
            tabBarScrollAnimation(visibility: .show, resetsAnimation: false)
            navigationBarScrollAnimation(visibility: .hide)
        } else if scrollViewScrollUp == true && scrollLengthForTabBarExtension < 46 {
            tabBarScrollAnimation(visibility: .hide, resetsAnimation: false)
            navigationBarScrollAnimation(visibility: .show)
        }
    }
    
    func navigationBarScrollAnimation(visibility: ViewVisibility){
        switch visibility {
        case .show:
            delegates.navigationBar.changeContainerViewBottomConstraint(visibility: false)
            navigationBarTopConstraint.constant = 0
        case .hide:
            delegates.navigationBar.changeContainerViewBottomConstraint(visibility: true)
            navigationBarTopConstraint.constant = -50
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            self.navigationBar.layoutIfNeeded()
            self.view.layoutIfNeeded()
        })
        
    }
    
    func tabBarScrollAnimation(visibility: ViewVisibility, resetsAnimation: Bool){
        switch visibility {
        case .show:
            scrollViewScrollUp = true
            tabBarWidthConstraint.changeMultiplier(multiplier: 1)
            tabBarHeightConstraint.constant = 70
            tabBarBottomConstraint.constant = 0
            delegates.customTabBar.increaseBottomConstraint(size: 30)
            delegates.customTabBar.goToTopButtonVisibily(visibily: .show)
        case .hide:
            scrollViewScrollUp = false
            NSLayoutConstraint.deactivate([tabBarWidthConstraint])
            NSLayoutConstraint.activate([tabBarWidthConstraint])
            tabBarHeightConstraint.constant = 50
            tabBarBottomConstraint.constant = 30
            delegates.customTabBar.increaseBottomConstraint(size: 10)
            delegates.customTabBar.goToTopButtonVisibily(visibily: .hide)
        }
        
        if resetsAnimation == true {
            navigationBarTopConstraint.constant = 30
            certifficateButton.isHidden = false
            navigationBarTopConstraint.constant = 0
            delegates.navigationBar.changeContainerViewBottomConstraint(visibility: false)
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, animations: {
            self.view.layoutIfNeeded()
            self.tabBar.layoutIfNeeded()
        })
    }
}

extension MainViewController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        delegates.enrollCertifficate.stopCapture()
        return nil
    }
}
