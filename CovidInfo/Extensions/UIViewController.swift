//
//  UIViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 17.02.2022.
//

import Foundation
import UIKit
import SwiftUI

extension UIViewController{
    func presentView(view: UIViewController, animated: Bool, presentationStyle: UIModalPresentationStyle, dismissPrevious: Bool){
        view.modalPresentationStyle = presentationStyle
        present(view, animated: animated, completion: nil)
        show(view, sender: self)
    }
    
    class func loadController() -> Self {
         return Self(nibName: String(describing: self), bundle: nil)
    }
    
    func addSubSwiftUIView<Content>(_ swiftUIView: Content, to view: UIView) where Content : View {
        let hostingController = UIHostingController(rootView: swiftUIView)
        hostingController.view.backgroundColor = .clear
        addChild(hostingController)
        view.addSubview(hostingController.view)
        view.backgroundColor = .clear
        
        defaultConstraints(childView: hostingController.view, parentView: view)
        hostingController.didMove(toParent: self)
    }
    
    func topMostViewController() -> UIViewController {
        if self.presentedViewController == nil {
            return self
        }
        if let navigation = self.presentedViewController as? UINavigationController {
            return navigation.visibleViewController!.topMostViewController()
        }
        if let tab = self.presentedViewController as? UITabBarController {
            if let selectedTab = tab.selectedViewController {
                return selectedTab.topMostViewController()
            }
            return tab.topMostViewController()
        }
        return self.presentedViewController!.topMostViewController()
    }
}
