//
//  SimptomeAndPreventieCollectionViewCell.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 08.02.2022.
//

import UIKit
import Lottie

class SimptomeAndPreventieCollectionViewCell: UICollectionViewCell {
    weak var lottieAnimation: AnimationView!
    weak var textLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    func setup(){
        setupContentView()
        setuplottieAnimation()
        setupTextLabel()
    }
    
    func setuplottieAnimation(){
        let lottieAnimation = AnimationView()
        lottieAnimation.setup(animationName: "", loopMode: .loop, animationSpeed: 0.5)
        
        self.contentView.addSubview(lottieAnimation)
        
        let constraints = Constraints(childView: lottieAnimation, parentView: self.contentView, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .top, multiplier: 1, constant: 50),
            Constraint(constraintType: .proportionalHeight, multiplier: 0.45, constant: 0),
            Constraint(constraintType: .aspectRatio, multiplier: (1.0 / 1.0), constant: 0),
        ])
        constraints.addConstraints()
        self.lottieAnimation = lottieAnimation
    }
    
    func setupTextLabel(){
        let textLabel = UILabel(frame: .zero)
        textLabel.textColor = .black
        textLabel.font = UIFont(name: "IBMPlexSans-Bold", size: 14)
        textLabel.numberOfLines = 0
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(textLabel)
        
        let constraints = Constraints(childView: textLabel, parentView: self.contentView, secondView: self.lottieAnimation, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .leading, multiplier: 1, constant: 20),
            Constraint(constraintType: .bottom, multiplier: 1, constant: -20),
            Constraint(constraintType: .verticalSpacing, multiplier: 1, constant: 0)
        ])
        constraints.addConstraints()
        
        self.textLabel = textLabel
        self.textLabel.textAlignment = .center
    }
    
    func setupContentView(){
        self.contentView.backgroundColor = .clear
        self.contentView.borderWidth = 2
        self.contentView.cornerRadius = 24
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        fatalError("Interface Builder is not supported!")
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        fatalError("Interface Builder is not supported!")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.textLabel.text = nil
    }
}
