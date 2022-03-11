//
//  HeadersData.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 11.03.2022.
//

import Foundation
import UIKit

class HeadersData{
    var image: UIImage
    var actionOnTap: UITapGestureRecognizer
    
    init(image: UIImage, actionOnTap: UITapGestureRecognizer){
        self.image = image
        self.actionOnTap = actionOnTap
    }
}

var headersData = [
    HeadersData(image: UIImage(named: "header1")!, actionOnTap: UITapGestureRecognizer()),
    HeadersData(image: UIImage(named: "header2")!, actionOnTap: UITapGestureRecognizer()),
    HeadersData(image: UIImage(named: "header3")!, actionOnTap: UITapGestureRecognizer())
]
