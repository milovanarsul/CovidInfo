//
//  EmbedView.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 04.02.2022.
//

import Foundation
import UIKit
import SwiftUI

class EmbedView{
    func embed(parent: UIViewController, container: UIView, child: Any, previous: UIViewController?){
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
    
    func onboardingViewController(parent: OnboardingViewController, container: UIView){
        let child = OnboardingPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        embed(parent: parent, container: container, child: child, previous: parent.children.first)
    }
    
    func mainPageViewController(parent: MainViewController, container: UIView){
        let child = MainPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        delegates.main = parent
        embed(parent: parent, container: container, child: child, previous: parent.children.first)
        delegates.tabBar = child
    }
    
    func simptomeAndPreventieViewController(parent: SimptomeAndPreventieViewController, container: UIView){
        let child = StaticCollectionViewController(collectionViewLayout: SimptomeAndPreventieLayout.init())
        delegates.staticInfo = parent
        embed(parent: parent, container: container, child: child, previous: parent.children.first)
    }
    
    func headerPageViewController(parent: UIViewController, container: UIView){
        let child = HeaderPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        embed(parent: parent, container: container, child: child, previous: parent.children.first)
    }
    
    func articleViewController(parent: UIViewController, container: UIView){
        let child = NewsViewController()
        delegates.news = child
        embed(parent: parent, container: container, child: child, previous: parent.children.first)
    }
    
    func infoCardsCollectionViewController(parent: UIViewController, container: UIView){
        let child = InfoCardsCollectionViewController(collectionViewLayout: InfoCardsCollectionViewLayout.init())
        embed(parent: parent, container: container, child: child, previous: parent.children.first)
        
    }
}

let embed = EmbedView()
