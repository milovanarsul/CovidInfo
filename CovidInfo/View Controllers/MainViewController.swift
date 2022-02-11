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
    
    var presentOnboarding: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        embed()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navTabAnimation()
    }
    
    
    func embed(){
        let navigationBar = CustomNavigationBar()
        navigationBar.frame = self.customNavigationBar.bounds
        self.customNavigationBar.addSubview(navigationBar)
        
        let embed = EmbedView()
        embed.mainPageViewController(parent: self, container: self.containerView, navigationBar: navigationBar)
        
        let customTabBar = CustomTabBar()
        customTabBar.frame = self.customTabBar.bounds
        self.customTabBar.addSubview(customTabBar)
    }
    
    @IBOutlet var navigationBarTopConstraint: NSLayoutConstraint!
    @IBOutlet var tabBarBottomConstraint: NSLayoutConstraint!
    
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

extension MainViewController: MainDelegate{
    func tabBarVisibility(tabBarVisibility: TabBarVisibility) {
        switch tabBarVisibility{
        case .hide:
            self.tabBarBottomConstraint.constant = -100
        case .show:
            self.tabBarBottomConstraint.constant = 34
        }
        
        UIView.animate(withDuration: 0.9, animations: {
            self.customTabBar.layoutIfNeeded()
            self.view.layoutIfNeeded()
        })
    }
}


