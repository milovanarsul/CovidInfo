//
//  NavigationBarDelegate.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 31.01.2022.
//

import Foundation

protocol NavigationBarDelegate{
    func setup(page: Page)
    func test()
}

enum currentPageButtonSlider{
    case left
    case right
}
