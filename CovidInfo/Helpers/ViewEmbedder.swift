//
//  OnboardingViewControllersEmbedde.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 31.01.2022.
//

import Foundation
import UIKit

class OnboardingViewControllersEmbedder{
    func embed(parent: GeneralOnboardingViewController, container: UIView, child: GeneralOnboardingPageViewController, previous: UIViewController?){
        
        if let previous = previous {
            removeFromParent(viewController: previous)
        }
        
        child.willMove(toParent: parent)
        parent.addChild(child)
        container.addSubview(child.view)
        child.didMove(toParent: parent)
        let w = container.frame.size.width;
        let h = container.frame.size.height;
        child.view.frame = CGRect(x: 0, y: 0, width: w, height: h)
    }
    
    func removeFromParent(viewController: UIViewController){
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
    
    func embed(withIdentifier id:String, parent:GeneralOnboardingViewController, container:UIView, completion:((UIViewController)->Void)? = nil){
        let vc = parent.storyboard!.instantiateViewController(withIdentifier: id)
        embed(
            parent: parent,
            container: container,
            child: vc as! GeneralOnboardingPageViewController,
            previous: parent.children.first
        )
        parent.nextButtonOnboardingDelegate = vc as! GeneralOnboardingPageViewController 
        (vc as! GeneralOnboardingPageViewController).laterButtonDelegate = parent
    }
}

class TabBarEmbedder{
    func embed(parent: MainViewController, container: UIView, child: MainPageViewController, previous: UIViewController?){
        
        if let previous = previous {
            removeFromParent(viewController: previous)
        }
        
        child.willMove(toParent: parent)
        parent.addChild(child)
        container.addSubview(child.view)
        child.didMove(toParent: parent)
        let w = container.frame.size.width;
        let h = container.frame.size.height;
        child.view.frame = CGRect(x: 0, y: 0, width: w, height: h)
    }
    
    func removeFromParent(viewController: UIViewController){
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
    
    func embed(withIdentifier id:String, parent:MainViewController, container:UIView, completion:((UIViewController)->Void)? = nil, navigationBar: CustomNavigationBar){
        let vc = parent.storyboard!.instantiateViewController(withIdentifier: id)
        (vc as! MainPageViewController).navigationBarDelegate = navigationBar
        embed(
            parent: parent,
            container: container,
            child: vc as! MainPageViewController,
            previous: parent.children.first
        )
        parent.tabBarDelegate = vc as! MainPageViewController
    }
}
