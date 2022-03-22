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
    
    init(image: UIImage){
        self.image = image
    }
}

var headersData = [
    HeadersData(image: UIImage(named: "header1")!),
    HeadersData(image: UIImage(named: "header2")!),
    HeadersData(image: UIImage(named: "header3")!)
]
