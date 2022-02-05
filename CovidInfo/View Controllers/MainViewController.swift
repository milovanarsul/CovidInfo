//
//  MainViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 27.01.2022.
//

import UIKit
import Lottie

class MainViewController: UIViewController {

    @IBOutlet var containerView: UIView!
    @IBOutlet var customNavigationBar: UIView!
    @IBOutlet var customTabBar: UIView!
    
    var tabBarDelegate: TabBarDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup(){
        embed()
        
        if OnboardingManager.shared.isFirstLaunch {
            onboardingAnimation()
            performSegue(withIdentifier: "toOnboarding", sender: nil)
            OnboardingManager.shared.isFirstLaunch = true
        } else{
            launchAnimation()
        }
    }
    
    func embed(){
        let navigationBar = CustomNavigationBar()
        //navigationBar.homePageDelegate = 
        navigationBar.frame = self.customNavigationBar.bounds
        self.customNavigationBar.addSubview(navigationBar)
        
        let embed = EmbedView()
        embed.mainPageViewController(parent: self, container: self.containerView, navigationBar: navigationBar)
        
        let customTabBar = CustomTabBar()
        customTabBar.frame = self.customTabBar.bounds
        customTabBar.tabBarDelegate = self.tabBarDelegate
        customTabBar.navigationBarDelegate = navigationBar
        self.customTabBar.addSubview(customTabBar)
    }
    
    @IBOutlet var navigationBarTopConstraint: NSLayoutConstraint!
    @IBOutlet var tabBarBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet var blankIcon: UIView!
    @IBOutlet var blankIconLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var blankIconTrailingConstraint: NSLayoutConstraint!
    @IBOutlet var blankIconTopConstraint: NSLayoutConstraint!
    @IBOutlet var blankIconBottomConstraint: NSLayoutConstraint!
    
    func launchAnimation(){
        self.blankIconLeadingConstraint.constant = 0
        self.blankIconTrailingConstraint.constant = 0
        self.blankIconTopConstraint.constant = 90
        self.blankIconBottomConstraint.constant = -3
        
        UIView.animate(withDuration: 1.3, animations: {
            self.blankIcon.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }, completion: {(finished: Bool) in
            self.blankIcon.isHidden = true
            self.containerView.isHidden = false
            self.navTabAnimation()
        })
    }
    
    func onboardingAnimation(){
        self.blankIcon.isHidden = true
        self.containerView.isHidden = false
        navTabAnimation()
    }
    
    func navTabAnimation(){
        self.navigationBarTopConstraint.constant = 54
        self.tabBarBottomConstraint.constant = 34
        
        UIView.animate(withDuration: 0.9, animations: {
            self.customNavigationBar.layoutIfNeeded()
            self.customTabBar.layoutIfNeeded()
            self.view.layoutIfNeeded()
        })
    }
}
