//
//  NavigationBarDelegate.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 31.01.2022.
//

import Foundation

protocol NavigationBarDelegates{
    func changeCurrentPageButton(title: String)
    func changePreviousPageButton(title: String)
    func buttonSlider(sliderType: currentPageButtonSlider)
    func currentPageSettings(shouldShowCurrentPageButton: Bool)
}

enum currentPageButtonSlider{
    case left
    case right
}
