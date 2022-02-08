//
//  EmbedView.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 04.02.2022.
//

import Foundation
import UIKit

class EmbedView{
    func embed(parent: UIViewController, container: UIView, child: Any, previous: UIViewController?){
        
        if let previous = previous {
            removeFromParent(viewController: previous)
        }
        
        (child as? UIViewController)!.willMove(toParent: parent)
        parent.addChild((child as? UIViewController)!)
        container.addSubview((child as? UIViewController)!.view)
        (child as? UIViewController)!.didMove(toParent: parent)
        (child as? UIViewController)!.view.frame = CGRect(x: 0, y: 0, width: container.frame.size.width, height: container.frame.size.height)
    }
    
    func removeFromParent(viewController: UIViewController){
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
    
    func generalOnboardingPageViewController(parent: GeneralOnboardingViewController, container: UIView){
        let child = OnboardingPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        embed(parent: parent, container: container, child: child, previous: parent.children.first)
        parent.nextButtonOnboardingDelegate = child
        child.laterButtonDelegate = parent
    }
    
    func mainPageViewController(parent: MainViewController, container: UIView, navigationBar: CustomNavigationBar){
        let child = MainPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        child.navigationBarDelegate = navigationBar
        child.mainDelegate = parent
        embed(parent: parent, container: container, child: child, previous: parent.children.first)
        parent.tabBarDelegate = child
        navigationBar.homePageDelegate = child.homePageDelegate
    }
    
    func simptomeAndPreventieViewController(parent: SimptomeAndPreventieViewController, container: UIView){
        let child = StaticCollectionViewController(collectionViewLayout: CardLayout.init())
        child.staticDelegate = parent
        embed(parent: parent, container: container, child: child, previous: parent.children.first)
    }
}
