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
    var backgroundImage: String
    var backgroundType: BackgroundType
    var title: String
    var date: String
    var link: String
    var description: String
    var author: String
    
    init(viewMode: CardMode? = .card, backgroundImage: String, backgroundType: BackgroundType, date: String, link: String, title: String, description: String, author: String){
        if let viewMode = viewMode {
            self.viewMode = viewMode
        }
        
        self.backgroundType = backgroundType
        self.backgroundImage = backgroundImage
        self.title = title
        self.date = date
        self.link = link
        self.description = description
        self.author = author
    }
}
