//
//  TabBarExtenstion.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 01.04.2022.
//

import Foundation
import UIKit
import BetterSegmentedControl

class TabBarExtension: UIView {
    lazy var tabBarExtension: BetterSegmentedControl = {
        let tabBarExtension = BetterSegmentedControl(frame: .zero, segments: LabelSegment.segments(withTitles: ["Surse verificate", "Surse neverificate"], normalFont: boldFont(size: 12), normalTextColor: .black, selectedFont: boldFont(size: 12) ,selectedTextColor: .black), options: [.backgroundColor(.white), .indicatorViewBackgroundColor(.lightGray), .cornerRadius(16), .animationSpringDamping(1.0)])
        tabBarExtension.addTarget(self, action: #selector(navigationSegmentedControlValueChanged(_:)), for: .valueChanged)
        return tabBarExtension
    }()
    
    func setup(){
        backgroundColor = .white
        addSubview(tabBarExtension)
        xyConstraints(childView: tabBarExtension, parentView: self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners([.topLeft, .topRight], radius: 10)
    }
    
    @objc func navigationSegmentedControlValueChanged(_ sender: BetterSegmentedControl){
        
    }
}
