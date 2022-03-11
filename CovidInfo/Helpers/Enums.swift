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
    case hideParent
}

enum MainPages{
    case account
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

enum ViewVisibility{
    case show
    case hide
}

enum TriajType{
    case intro
    case text
    case form
    case finish
}

enum TriajAction{
    case button
    case buttonForm
    case buttonStack
    case none
}

enum PresentationSize{
    case small
    case medium
    case large
    case fullScreen
}

enum CertifficateEnrollment{
    case enrolled
    case notEnrolled
}

enum StorageStye{
    case userDefaults
    case fileSystem
}
