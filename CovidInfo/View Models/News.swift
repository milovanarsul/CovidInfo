//
//  NewsData.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 23.03.2022.
//

import Foundation
import UIKit

public class TrustedSourceData{
    var image: String
    var text: String
    var url: String
    
    init(image: String, text: String, url: String){
        self.image = image
        self.text = text
        self.url = url
    }
}
