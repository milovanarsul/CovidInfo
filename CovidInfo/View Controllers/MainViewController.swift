//
//  MainViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 27.01.2022.
//

import UIKit
import Lottie

import UIKit
import Lottie

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navTabAnimation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setup()
    }
    
    var tabBarBottomConstraint = NSLayoutConstraint()
    var certifficateButtonBottomConstraint = NSLayoutConstraint()
    
    func setup(){
        view.backgroundColor = .white
        view.addSubviews(views: [navigationBar, contentView, certifficateButton, tabBar])
        
        let navigationBarConstraints = Constraints(childView: navigationBar, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .height, multiplier: 1, constant: 80),
            Constraint(constraintType: .top, multiplier: 1, constant: 30)
        ])
        navigationBarConstraints.addConstraints()
        
        let contentViewConstraints = Constraints(childView: contentView, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalHeight, multiplier: 0.88, constant: 0),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 0)
        ])
        contentViewConstraints.addConstraints()
        
        let tabBarConstraints = Constraints(childView: tabBar, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 0.85, constant: 0),
            Constraint(constraintType: .height, multiplier: 1, constant: 50)
        ])
        tabBarConstraints.addConstraints()
        tabBarBottomConstraint = Constraint(childView: tabBar, parentView: view, constraintType: .bottom, multiplier: 1, constant: 30).setConstraint()
        NSLayoutConstraint.activate([tabBarBottomConstraint])
        
        certifficateButtonBottomConstraint = NSLayoutConstraint(item: view!, attribute: .bottom, relatedBy: .equal, toItem: certifficateButton, attribute: .bottom, multiplier: 1, constant: 90)
        NSLayoutConstraint.activate([certifficateButtonBottomConstraint, Constraint(childView: certifficateButton, parentView: view, constraintType: .horizontal, multiplier: 1, constant: 0).setConstraint()])

    }
    
    func navTabAnimation(){
        animateConstraints(constraints: [(tabBarBottomConstraint, 34, .constant), (certifficateButtonBottomConstraint, 100, .constant)])
        
        UIView.animate(withDuration: 0.6,animations: {
            self.navigationBar.layoutIfNeeded()
            self.tabBar.layoutIfNeeded()
        }, completion: {(finished: Bool) in
            self.certifficateButtonAnimation(visibility: .show)
            self.view.layoutIfNeeded()
        })
    }
    
    @objc func certifficateButtonTapped(_ sender: UIButton) {
        defaults.bool(forKey: "certifficateEnrolled") ? certifficateModal() : enrollCertifficate()
    }
}

extension MainViewController: MainDelegate{
    func updateCertifficateButton(){
        self.certifficateButton.initialize(title: defaults.bool(forKey: "certifficateEnrolled") ? "Certificatul tau" : "Inroleaza certificat", titleColor: .white, cornerRadius: 24, font: boldFont(size: 14), backgroundColor: defaults.bool(forKey: "certifficateEnrolled") ? signatureDarkBlue : .red, contentInsets: NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20), image: UIImage(systemName: "qrcode.viewfinder"))
    }
    
    func dimissModal(completion: @escaping (() -> Void)) {
        dismiss(animated: true, completion: completion)
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
            self.tabBar.layoutIfNeeded()
            self.view.layoutIfNeeded()
        })
    }
    
    func certifficateButtonAnimation(visibility: ViewVisibility){
        switch visibility {
        case .show:
            certifficateButtonBottomConstraint.constant = 90
        case .hide:
            certifficateButtonBottomConstraint.constant = 40
        }
        
        UIView.animate(withDuration: 0.6, animations: {
            self.certifficateButton.layoutIfNeeded()
            self.view.layoutIfNeeded()
        })
    }
    
    func certifficateButtonVisibility(visibility: ViewVisibility){
        switch visibility {
        case .show:
            certifficateButton.isHidden = false
        case .hide:
            certifficateButton.isHidden = true
        }
    }
    
    func presentArticleViewController(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25){
            CovidInfo.embed.articleViewController(parent: self, container: self.view)
            self.view.bringSubviewToFront(self.certifficateButton)
            self.view.bringSubviewToFront(self.tabBar)
            articlesViewControllerHasBeenPresented = true
        }
    }
    
    func dismissArticleViewController(){
        delegates.news.removeViewController()
    }
    
    func increaseContainerView(size: CGFloat){
        
    }
}

extension MainViewController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        delegates.enrollCertifficate.stopCapture()
        return nil
    }
}

