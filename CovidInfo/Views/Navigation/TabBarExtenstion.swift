//
//  TabBarExtenstion.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 01.04.2022.
//

import Foundation
import UIKit
import BetterSegmentedControl

var trusted: Bool = false

class TabBarExtension: UIView {
    lazy var tabBarExtension: BetterSegmentedControl = {
        let tabBarExtension = BetterSegmentedControl(frame: .zero, segments: LabelSegment.segments(withTitles: ["Surse media", "Surse oficiale"], normalFont: boldFont(size: 12), normalTextColor: .black, selectedFont: boldFont(size: 12) ,selectedTextColor: .white), options: [.backgroundColor(.white), .indicatorViewBackgroundColor(signatureDarkBlue), .cornerRadius(16), .animationSpringDamping(1.0)])
        tabBarExtension.addTarget(self, action: #selector(navigationSegmentedControlValueChanged(_:)), for: .valueChanged)
        return tabBarExtension
    }()
    
    init(){
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
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
        switch sender.index {
            case 0: trusted = false
            default: trusted = true
        }
        
        delegates.news.refreshData()
    }
}
