//
//  TabBarDelegate.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 01.02.2022.
//

import Foundation
import UIKit

protocol TabBarDelegate{
    func goToPage(pageIndex: Int, direction: UIPageViewController.NavigationDirection)
}

enum tabBarButtons{
    case home
    case news
    case statistics
    case documents
}


