//
//  Simptome.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 05.02.2022.
//

import UIKit

class Simptome: XIB {

    var homePageDelegate: HomePageDelegate!
    
    @IBAction func button1(_ sender: Any) {
        homePageDelegate.goToPage(pageIndex: 0, direction: .reverse)
    }
    
    
    @IBAction func button2(_ sender: Any) {
        homePageDelegate.goToPage(pageIndex: 1, direction: .reverse)
    }
    
    
    @IBAction func button3(_ sender: Any) {
        homePageDelegate.goToPage(pageIndex: 3, direction: .forward)
    }
}
