//
//  Safari.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 23.03.2022.
//

import Foundation
import UIKit
import SafariServices

func showWebPage(url: String, viewController: UIViewController){
    if let url = URL(string: url){
        let config = SFSafariViewController.Configuration()
        
        let safariViewController = SFSafariViewController(url: url, configuration: config)
        viewController.present(safariViewController, animated: true)
    }
}
