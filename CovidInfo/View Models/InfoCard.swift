//
//  InfoCardViewModel.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 04.05.2022.
//

import Foundation
import Firebase

class InfoCardsData {
    var title: String
    var content: String
    
    init(title: String, content: String){
        self.title = title
        self.content = content
    }
}
