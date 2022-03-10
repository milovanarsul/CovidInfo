//
//  UIViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 17.02.2022.
//

import Foundation
import UIKit

extension UIViewController{
    func presentView(view: UIViewController, animated: Bool, presentationStyle: UIModalPresentationStyle, dismissPrevious: Bool){
        view.modalPresentationStyle = presentationStyle
        present(view, animated: animated, completion: nil)
        show(view, sender: self)
    }
    
    class func loadController() -> Self {
         return Self(nibName: String(describing: self), bundle: nil)
    }
}
