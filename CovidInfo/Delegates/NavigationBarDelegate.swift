//
//  NavigationBarDelegate.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 31.01.2022.
//

import Foundation

protocol NavigationBarDelegate{
    func changeCurrentPageButton(title: String)
    func changePreviousPageButton(title: String)
    func buttonSlider(sliderType: currentPageButtonSlider)
    func currentPageSettings(shouldShowCurrentPageButton: Bool)
    func test()
}

enum currentPageButtonSlider{
    case left
    case right
}
