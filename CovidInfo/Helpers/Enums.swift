//
//  Enums.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 04.02.2022.
//

import Foundation

enum ConstraintType{
    case height
    case width
    case leading
    case trailing
    case top
    case bottom
    case bottomReverse
    case horizontal
    case vertical
    case aspectRatio
    case proportionalHeight
    case proportionalWidth
    case verticalSpacing
    case horizontalSpacing
}

enum currentPageButtonSlider{
    case left
    case right
}

enum MainPages{
    case home
    case news
    case statistics
    case documents
}

enum ChildPages{
    case none
    case triaj
    case preventie
    case simptome
}

enum StaticType{
    case simptome
    case preventie
}

enum TabBarVisibility{
    case show
    case hide
}

enum PageController{
    case onboarding
    case main
    case home
    case triaj
}
