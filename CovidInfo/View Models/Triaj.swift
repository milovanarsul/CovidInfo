//
//  TriajData.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 09.02.2022.
//

import Foundation
import UIKit

var riskPrecentage: Double = 0
let highRisk: Double = 2.5

class TriajData{
    var image: String
    var title: String
    var titleColor: UIColor? = .black
    var subViewType: TriajType
    var subView: Any!
    var actionType: TriajAction
    var actionTitle: Any!
    var actionForeground: UIColor!
    var actionColour: UIColor!
    var actionSize: CGFloat!
    
    init(image: String, title: String, titleColor: UIColor? = nil, subViewType: TriajType, subView: Any? = nil, actionType: TriajAction, actionTitle: Any? = nil, actionForegorund: UIColor? = nil, actionColor: UIColor? = nil, actionSize: CGFloat){
        self.image = image
        self.title = title
        
        if let titleColor = titleColor {
            self.titleColor = titleColor
        }
        
        self.subViewType = subViewType
        
        if let subView = subView {
            self.subView = subView
        }
    
        self.actionType = actionType
        
        if let actionTitle = actionTitle {
            self.actionTitle = actionTitle
        }
        
        if let actionForegorund = actionForegorund {
            self.actionForeground = actionForegorund
        }
        
        if let actionColor = actionColor {
            self.actionColour = actionColor
        }
        
        self.actionSize = actionSize
    }
}

