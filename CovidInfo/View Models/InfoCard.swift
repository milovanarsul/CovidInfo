//
//  InfoCardViewModel.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 04.05.2022.
//

import Foundation

class InfoCardsData {
    var frontTitle: String
    var contents: String
    
    init(frontTitle: String, contents: String){
        self.frontTitle = frontTitle
        self.contents = contents
    }
}

let infoCardsDataArray: [InfoCardsData] = []
