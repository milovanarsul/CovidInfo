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
    @IBOutlet weak var certifficateButton: UIButton!
    
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
    @IBOutlet weak var certifficateButtonConstraint: NSLayoutConstraint!
    
    func navTabAnimation(){
        self.navigationBarTopConstraint.constant = 54
        self.tabBarBottomConstraint.constant = 34
        
        UIView.animate(withDuration: 0.6,animations: {
            self.customNavigationBar.layoutIfNeeded()
            self.customTabBar.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }, completion: {(finished: Bool) in
            self.certifficateButtonAnimation(visibility: .show)
        })
    }
    
    @IBAction func certifficateButtonTapped(_ sender: Any) {
        showCertifficateView()
    }
}

extension MainViewController: MainDelegate{
    func tabBarVisibility(tabBarVisibility: ViewVisibility) {
        switch tabBarVisibility{
        case .hide:
            self.tabBarBottomConstraint.constant = -150
        case .show:
            self.tabBarBottomConstraint.constant = 34
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.customTabBar.layoutIfNeeded()
            self.view.layoutIfNeeded()
        })
    }
    
    func certifficateButtonAnimation(visibility: ViewVisibility){
        switch visibility {
        case .show:
            self.certifficateButtonConstraint.constant = 15
        case .hide:
            self.certifficateButtonConstraint.constant = -45
        }
        
        UIView.animate(withDuration: 0.6, animations: {
            self.certifficateButton.layoutIfNeeded()
            self.view.layoutIfNeeded()
        })
    }
    
    func showCertifficateView(){
        let slideInViewController = SlideInView()
        slideInViewController.modalPresentationStyle = .custom
        slideInViewController.transitioningDelegate = self
        self.present(slideInViewController, animated: true, completion:  nil)
    }
    
    func presentEnrollCertifficate(){
        self.dismiss(animated: true, completion: nil)
        let modal = UIViewController()
        modal.view = OnboardingModal()
        modal.presentationController?.delegate = self
        present(modal, animated: true, completion: nil)
    }
}

extension MainViewController: UIViewControllerTransitioningDelegate{
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController?{
        SlideInPresentationController(presentedViewController: presented, presenting: presenting)
    }
}

extension MainViewController:UIAdaptivePresentationControllerDelegate {
    public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        
    }
}

