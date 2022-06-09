//
//  SimptomeAndPreventieCollectionViewCell.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 08.02.2022.
//

import UIKit
import Lottie

class SimptomeAndPreventieCollectionViewCell: UICollectionViewCell {
    var lottieAnimation = AnimationView()
    var textLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        self.borderColor = .red
    }
    
    func setup(){
        setupContentView()
        setuplottieAnimation()
        setupTextLabel()
    }
    
    func setuplottieAnimation(){
        lottieAnimation.setup(animationName: "", loopMode: .loop, animationSpeed: 0.5, container: contentView)
        self.contentView.addSubview(lottieAnimation)
        
        let constraints = Constraints(childView: lottieAnimation, parentView: self.contentView, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .top, multiplier: 1, constant: 50),
            Constraint(constraintType: .proportionalHeight, multiplier: 0.45, constant: 0),
            Constraint(constraintType: .aspectRatio, multiplier: (1.0 / 1.0), constant: 0),
        ])
        constraints.addConstraints()
    }
    
    func setupTextLabel(){
        textLabel.initialize(text: "", color: .black, font: boldFont(size: 14), alignment: .center, lines: 0)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(textLabel)
        
        let constraints = Constraints(childView: textLabel, parentView: self.contentView, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .leading, multiplier: 1, constant: 30),
            Constraint(constraintType: .bottom, multiplier: 1, constant: -20),
        ])
        constraints.addConstraints()
        textLabel.topAnchor.constraint(equalTo: lottieAnimation.bottomAnchor).isActive = true
    }
    
    func setupContentView(){
        self.contentView.backgroundColor = .clear
        self.contentView.borderWidth = 2
        self.contentView.cornerRadius = 24
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.textLabel.text = nil
    }
}
