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
    @IBOutlet var background: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        background.fadeOut(duration: 0.4)
        navTabAnimation()
        embed()
    }
    
    func embed(){
        let navigationBar = CustomNavigationBar()
        self.customNavigationBar.addSubView(parentView: self.customNavigationBar, childView: navigationBar)
        
        let embed = EmbedView()
        embed.mainPageViewController(parent: self, container: self.containerView, navigationBar: navigationBar)
        
        self.customTabBar.addSubView(parentView: self.customTabBar, childView: CustomTabBar())
    }
    
    @IBOutlet var navigationBarTopConstraint: NSLayoutConstraint!
    @IBOutlet var tabBarBottomConstraint: NSLayoutConstraint!
    
    func navTabAnimation(){
        self.navigationBarTopConstraint.constant = 54
        self.tabBarBottomConstraint.constant = 34
        
        UIView.animate(withDuration: 0.6,animations: {
            self.customNavigationBar.layoutIfNeeded()
            self.customTabBar.layoutIfNeeded()
            self.view.layoutIfNeeded()
        })
    }
    
    @IBAction func testButton(_ sender: Any) {
        let slideInViewController = SlideInView()
        slideInViewController.modalPresentationStyle = .custom
        slideInViewController.transitioningDelegate = self
        self.present(slideInViewController, animated: true, completion:  nil)
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
        
        UIView.animate(withDuration: defaultAnimationDuration, animations: {
            self.customTabBar.layoutIfNeeded()
            self.view.layoutIfNeeded()
        })
    }
}

extension MainViewController: UIViewControllerTransitioningDelegate{
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController?{
        SlideInPresentationController(presentedViewController: presented, presenting: presenting)
    }
}


