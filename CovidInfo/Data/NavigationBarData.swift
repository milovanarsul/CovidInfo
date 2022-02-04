//
//  NavigationBarData.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 01.02.2022.
//

import Foundation

class Page{
    private var parentPage: String?
    private var childPage: String?
    public var childType: ChildPages?
    
    init(mainPage: MainPages, childType: ChildPages){
        self.childType = childType
        
        let pageData = mainPages[mainPage]
        for (pageTitle, subPages) in pageData!{
            self.parentPage = pageTitle
            
            if childType != .none{
                self.childPage = subPages[childType]
            }
        }
    }

    func getParentPage() -> String{
        return self.parentPage!
    }
    
    func getChildPage() -> String{
        return self.childPage!
    }
}


let mainPages: [MainPages:[String:[ChildPages:String]]] = [
    MainPages.home: ["Acasa":homePages],
    MainPages.news: ["Stiri":stiriPages],
    MainPages.statistics: ["Statistici":statisticiPages],
    MainPages.documents: ["Documente":documentePages]
]

let homePages: [ChildPages:String] = [
    ChildPages.triaj: "Triaj",
    ChildPages.preventie: "Preventie",
    ChildPages.simptome: "Simptome"
]

let stiriPages: [ChildPages:String] = [:]
let statisticiPages: [ChildPages:String] = [:]
let documentePages: [ChildPages:String] = [:]

