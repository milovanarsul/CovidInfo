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

class Article {
    var viewMode: CardMode? = .card
    var backgroundImage: String
    var backgroundType: BackgroundType
    var title: String
    var date: String
    var link: String
    var description: String
    var author: String
    var isTrusted: Bool
    
    init(viewMode: CardMode? = .card, backgroundImage: String, backgroundType: BackgroundType, date: String, link: String, title: String, description: String, author: String, isTrusted: Bool){
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
        self.isTrusted = isTrusted
    }
}
