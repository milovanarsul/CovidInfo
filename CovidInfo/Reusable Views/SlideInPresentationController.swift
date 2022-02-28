//
//  SlideInPresentationController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 26.02.2022.
//

import Foundation
import UIKit

class SlideInPresentationController: UIPresentationController{
    let blurEffectView: UIVisualEffectView!
    var tapGestureRecognizer: UITapGestureRecognizer!
    var presentationSize: PresentationSize!
    private var presentationHeight: PresentationSize!
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?){
        
        let blurEffect = UIBlurEffect(style: .dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        delegates.customPresentation = self
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissController))
        self.blurEffectView.isUserInteractionEnabled = true
        self.blurEffectView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override var frameOfPresentedViewInContainerView: CGRect{
        presentationFrame(presentationSize: self.presentationHeight)
    }
    
    override func presentationTransitionWillBegin() {
        self.blurEffectView.alpha = 0
        self.containerView?.addSubview(blurEffectView)
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: {(UIViewControllerTransitionCoordinatorContext) in self.blurEffectView.alpha = 0.7}, completion: {(UIViewControllerTransitionCoordinatorContext) in })
    }
    
    override func dismissalTransitionWillBegin() {
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: {(UIViewControllerTransitionCoordinatorContext) in self.blurEffectView.alpha = 0}, completion: {(UIViewControllerTransitionCoordinatorContext) in self.blurEffectView.removeFromSuperview()})
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        presentedView?.roundCorners([.topLeft, .topRight], radius: 24)
    }
    
    override func containerViewDidLayoutSubviews(){
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
        blurEffectView.frame = containerView!.bounds
    }
    
    @objc func dismissController(){
        self.presentedViewController.dismiss(animated: true, completion: nil)
    }
}

extension SlideInPresentationController{
    func presentationFrame(presentationSize: PresentationSize) -> CGRect{
        let presentationDimension: CGFloat = presentationSizes[presentationSize]!
        
        return CGRect(origin: CGPoint(x: 0, y: self.containerView!.frame.height * (1 - presentationDimension)), size: CGSize(width: self.containerView!.frame.width, height: self.containerView!.frame.height * presentationDimension))
    }
}

extension SlideInPresentationController: CustomPresentationDelegate{
    func setPresentationHeight(presentationHeight: PresentationSize) {
        self.presentationHeight = presentationHeight
    }
}
