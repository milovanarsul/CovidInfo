//
//  CertifficateViews.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 09.03.2022.
//

import Foundation
import UIKit

class CertifficateView: UIView{
    private var imageView = UIImageView()
    private var label = UILabel()
    private var button = UIButton()
    
    func setup(){
        imageView.image = UIImage(named: "QR")
        imageView.contentMode = .scaleAspectFit
        self.addSubview(imageView)
        defaultConstraints(childView: imageView, parentView: self)
    }
}
