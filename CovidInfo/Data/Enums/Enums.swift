//
//  Enums.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 04.02.2022.
//

import Foundation
import UIKit

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

enum SetConstraintType{
    case multiplier
    case constant
}

enum currentPageButtonSlider{
    case left
    case right
    case hideParent
}

enum MainPages{
    case home
    case info
    case news
    case statistics
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

@objc
public enum BackgroundType: Int16 {
    case light
    case dark
    
    var titleTextColor: UIColor {
        switch self {
        case .dark:
            return .white
        case .light:
            return .gray
        }
    }
}

enum ShadowAction{
    case add
    case remove
}

@objc
public enum CardMode: Int16 {
    case full
    case card
}

enum CardsTableViewType{
    case news
    case variants
}

enum InfoCardsType{
    case intrebariFrecvente
    case vaccinare
}

enum JSONFile: String{
    case date2022 = "https://raw.githubusercontent.com/milovanarsul/CovidInfo/main/Data/data2022.json"
    case date2021 = "data2021"
    case date2020 = "data2020"
}

enum NewsType{
    case trused
    case untrusted
}

enum DataType{
    case preventie
    case simptome
}

enum ImageType{
    case custom
    case system
}

enum TripViewType{
    case arrival
    case departure
}

enum CountryTravelTableViewCellType {
    case normal
    case custom
}

enum CountryCompare{
    case country1
    case country2
}
