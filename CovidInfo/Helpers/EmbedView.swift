//
//  EmbedView.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 04.02.2022.
//

import Foundation
import UIKit

class EmbedView{
    func embed(parent: UIViewController, container: UIView, child: Any, previous: UIViewController?, y: CGFloat){
        
        if let previous = previous {
            removeFromParent(viewController: previous)
        }
        
        (child as? UIViewController)!.willMove(toParent: parent)
        parent.addChild((child as? UIViewController)!)
        container.addSubview((child as? UIViewController)!.view)
        (child as? UIViewController)!.didMove(toParent: parent)
        (child as? UIViewController)!.view.frame = CGRect(x: 0, y: y, width: container.frame.size.width, height: container.frame.size.height)
    }
    
    func removeFromParent(viewController: UIViewController){
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
    
    func onboardingViewController(parent: GeneralOnboardingViewController, container: UIView){
        let child = OnboardingPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        embed(parent: parent, container: container, child: child, previous: parent.children.first, y: 0)
    }
    
    func mainPageViewController(parent: MainViewController, container: UIView, navigationBar: CustomNavigationBar){
        let child = MainPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        delegates.navigationBar = navigationBar
        delegates.main = parent
        embed(parent: parent, container: container, child: child, previous: parent.children.first, y: 10)
        delegates.tabBar = child
    }
    
    func simptomeAndPreventieViewController(parent: SimptomeAndPreventieViewController, container: UIView){
        let child = StaticCollectionViewController(collectionViewLayout: SimptomeAndPreventieLayout.init())
        delegates.staticInfo = parent
        embed(parent: parent, container: container, child: child, previous: parent.children.first, y: 0)
    }
}
