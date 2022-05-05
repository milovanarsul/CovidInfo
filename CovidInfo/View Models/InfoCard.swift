//
//  InfoCardViewModel.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 04.05.2022.
//

import Foundation
import Firebase

class InfoCardsData {
    var cardID: Int
    var frontTitle: String
    var contents: String
    
    init(cardID: Int, frontTitle: String, contents: String){
        self.cardID = cardID
        self.frontTitle = frontTitle
        self.contents = contents
    }
}
