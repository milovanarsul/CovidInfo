//
//  UIButton.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 01.03.2022.
//

import Foundation
import UIKit

extension UIButton{
    func initialize(title: String, titleColor: UIColor, cornerRadius: CGFloat, font: UIFont, backgroundColor: UIColor, contentInsets: NSDirectionalEdgeInsets? = nil, image: UIImage? = nil){
        
        var buttonAttributeContainer: AttributeContainer{
            var container = AttributeContainer()
            container.font = font
            container.foregroundColor = .white
            
            return container
        }
        
        var configuration = UIButton.Configuration.plain()
        configuration.title = title
        configuration.attributedTitle = AttributedString(title, attributes: buttonAttributeContainer)
        configuration.background.cornerRadius = cornerRadius
        configuration.background.backgroundColor = backgroundColor
        
        if let image = image {
            configuration.image = image
            configuration.image?.withTintColor(.white)
            configuration.imagePadding = 10
            configuration.imagePlacement = .leading
        }
        
        if let contentInsets = contentInsets {
            configuration.contentInsets = contentInsets
        }
        
        self.configuration = configuration
        self.tintColor = .white
    }
    
    func initializeIcon(image: UIImage? = nil, backgroundImage: UIImage? = nil,  backgroundColor: UIColor? = .clear, contentInsets: NSDirectionalEdgeInsets? = nil){
        var configuration = UIButton.Configuration.plain()
        
        if let backgroundImage = backgroundImage {
            configuration.background.image = backgroundImage
            configuration.background.imageContentMode = .scaleAspectFit
        }
        
        if let image = image {
            configuration.image = image
            configuration.image?.withTintColor(.black)
            configuration.imagePadding = 10
            configuration.imagePlacement = .leading
        }
        
        if let backgroundColor = backgroundColor {
            configuration.background.backgroundColor = backgroundColor
        }
        
        if let contentInsets = contentInsets {
            configuration.contentInsets = contentInsets
        }
        
        self.configuration = configuration
        self.tintColor = .black
    }
}
