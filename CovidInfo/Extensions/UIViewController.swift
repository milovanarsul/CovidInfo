//
//  UIViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 17.02.2022.
//

import Foundation
import UIKit
import SwiftUI
import SwiftUICharts

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
        addChild(hostingController)
        hostingController.view.backgroundColor = .clear
        hostingController.view.cornerRadius = 24
        view.addSubview(hostingController.view)
        
        defaultConstraints(childView: hostingController.view, parentView: view)
        hostingController.didMove(toParent: self)
    }
}
