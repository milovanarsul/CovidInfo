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
        updateCertifficateButton()
    }
    
    @IBOutlet var navigationBarTopConstraint: NSLayoutConstraint!
    @IBOutlet var tabBarBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var certifficateButtonConstraint: NSLayoutConstraint!
    
    func navTabAnimation(){
        self.navigationBarTopConstraint.constant = 30
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
        defaults.isCertifficateEnrolled() ? certifficateModal() : enrollCertifficate()
    }
}

extension MainViewController: MainDelegate{
    func updateCertifficateButton(){
        self.certifficateButton.initialize(title: defaults.isCertifficateEnrolled() ? "Certificatul tau" : "Inroleaza certificat", titleColor: .white, cornerRadius: 24, font: boldFont(size: 14), backgroundColor: defaults.isCertifficateEnrolled() ? signatureDarkBlue : .red, contentInsets: NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20), image: UIImage(systemName: "qrcode.viewfinder"))
    }
    
    func dimissModal(completion: @escaping (() -> Void)) {
        dismiss(animated: true, completion: completion)
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
    
    func accountModal() {
        let viewController = AccountViewController()
        viewController.view.backgroundColor = .white
        viewController.modalPresentationStyle = .pageSheet
        if let sheet = viewController.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.preferredCornerRadius = 24
            sheet.prefersGrabberVisible = true
        }
        
        present(viewController, animated: true, completion: nil)
    }
    
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
}

