//
//  NewsData.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 23.03.2022.
//

import Foundation
import UIKit

class TrustedSourceData{
    var image: String
    var text: String
    var url: String
    
    init(image: String, text: String, url: String){
        self.image = image
        self.text = text
        self.url = url
    }
}

let trustedSourcesData = [
    TrustedSourceData(image: "datelazi", text: "Date la zi", url: "https://datelazi.ro"),
    TrustedSourceData(image: "ecdc", text: "ECDC", url: "https://www.ecdc.europa.eu/en"),
    TrustedSourceData(image: "ema", text: "EMA", url: "https://www.ema.europa.eu/en"),
    TrustedSourceData(image: "eu", text: "EU", url: "https://european-union.europa.eu/index_ro"),
    TrustedSourceData(image: "ms", text: "MS", url: "https://www.ms.ro"),
    TrustedSourceData(image: "stirioficiale", text: "Stiri oficiale", url: "https://stirioficiale.ro/informatii"),
    TrustedSourceData(image: "who", text: "WHO", url: "https://www.who.int")
]

class Article {
    var viewMode: CardMode? = .card
    var backgroundImage: UIImage
    var backgroundType: BackgroundType
    var title: String
    var subtitle: String
    var description: String
    
    init(viewMode: CardMode? = .card, backgroundImage: UIImage, backgroundType: BackgroundType, title: String, subtitle: String, description: String){
        if let viewMode = viewMode {
            self.viewMode = viewMode
        }
        self.backgroundImage = backgroundImage
        self.backgroundType = backgroundType
        self.title = title
        self.subtitle = subtitle
        self.description = description
    }
}
