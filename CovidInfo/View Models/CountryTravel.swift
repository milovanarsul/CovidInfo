//
//  CountryTravel.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 27.05.2022.
//

import Foundation
import UIKit

class CountryTravelModel {
    var icon: String?
    var title: String?
    var subtitle: [String : UIColor]?
    var text: String?
    var height: CGFloat?
    
    init(icon: String, title: String, subtitle: String, text: String? = nil){
        self.icon = icon
        self.title = title
        
        if let subtitleText = risksLocalizable[subtitle]{
            self.subtitle = subtitleText
        } else {
            TranslatorManager.translate(text: subtitle) { translation in
                self.subtitle = [translation! : signatureDarkBlue]
            }
        }
        
        if let text = text {
            TranslatorManager.translate(text: text) { translation in
                self.text = translation
            }
            self.text = text
            self.height = self.text!.height(withConstrainedWidth: UIScreen.main.bounds.width - 24, font: UIFont(name: "IBMPlexSans-Regular", size: 12)!) - 30
        } else {
            self.height = 80
        }
    }
}
