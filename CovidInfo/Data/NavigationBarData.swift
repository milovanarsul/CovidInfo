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

