//
//  CountryTravel.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 27.05.2022.
//

import Foundation
import UIKit

class CountryTravelModel {
    var icon: UIImage?
    var title: String?
    var subtitle: (String, UIColor)?
    var text: String?
    var height: CGFloat
    
    init(icon: UIImage, title: String, subtitle: (String, UIColor), text: String? = nil){
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
        
        if let text = text {
            self.text = text
            self.height = text.height(withConstrainedWidth: UIScreen.main.bounds.width - 24, font: UIFont(name: "IBMPlexSans-Regular", size: 12)!) - 30
        } else {
            self.height = 80
        }
    }
}
