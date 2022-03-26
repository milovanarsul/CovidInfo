//
//  NewsArticleView.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 26.03.2022.
//

import UIKit

class CardView: UIView {
    lazy var shadowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white.withAlphaComponent(0.20)
        return view
    }()
    
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = article.backgroundType.titleTextColor
        return label
    }()
    
    lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()
    
    lazy var newsSourceLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .green
        imageView.cornerRadius = 14
        return imageView
    }()
    
    lazy var sourceInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.initalize(axis: .horizontal, alignment: .fill, distribution: .fill, spacing: 5)
        stackView.backgroundColor = .blue
        return stackView
    }()
    
    var containerViewLeadingConstraint: NSLayoutConstraint!
    var containerViewTrailingConstraint: NSLayoutConstraint!
    var containerViewTopConstraint: NSLayoutConstraint!
    var containerViewBottomConstraint: NSLayoutConstraint!
    
    var article: Article
    
    init(article: Article) {
        self.article = article

        super.init(frame: .zero)
        
        containerViewLeadingConstraint = containerView.leftAnchor.constraint(equalTo: self.leftAnchor)
        containerViewTrailingConstraint = containerView.rightAnchor.constraint(equalTo: self.rightAnchor)
        containerViewTopConstraint = containerView.topAnchor.constraint(equalTo: self.topAnchor)
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func setup(){
        backgroundColor = .clear
        addSubview(shadowView)
        addSubview(containerView)
        
        if article.viewMode == .card {
            updateLayout(for: .card)
            containerView.layer.cornerRadius = 20
            containerView.layer.masksToBounds = true
        } else {
            updateLayout(for: .full)
            containerView.layer.cornerRadius = 0
            containerView.layer.masksToBounds = true
        }
        
        defaultAnchors(childView: shadowView, parentView: containerView)
        addConstraints([containerViewLeadingConstraint, containerViewTrailingConstraint, containerViewTopConstraint, containerViewBottomConstraint])
        
        setupBackgroundImage()
        setupBottomView()
        setupTitle()
    }
    
    private func setupBackgroundImage() {
        let backgroundImage = article.backgroundImage
        backgroundImageView.image = backgroundImage

        containerView.addSubview(backgroundImageView)
        defaultAnchors(childView: backgroundImageView, parentView: containerView)
        let topPadding = UIWindow.topPadding
        var top: CGFloat = 25.0
        
        if article.viewMode == .full {
            top = max(top, topPadding + 5)
        }
    }
    
    private func setupTitle() {
        titleLabel.initialize(text: article.title, color: .white, font: boldFont(size: 28), alignment: .left, lines: 0)
        containerView.addSubview(titleLabel)
        
        let topPadding = UIWindow.topPadding
        var top: CGFloat = 20.0
        if article.viewMode == .full {
            top = max(top, topPadding)
        }
        
        let titleConstraints = Constraints(childView: titleLabel, parentView: containerView, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 20),
            Constraint(constraintType: .trailing, multiplier: 1, constant: -20)
        ])
        titleConstraints.addConstraints()
        NSLayoutConstraint.activate([NSLayoutConstraint(item: bottomView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 10)])
    }
    
    private func setupBottomView(){
        containerView.addSubview(bottomView)
        let bottomViewConstraints = Constraints(childView: bottomView, parentView: containerView, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalHeight, multiplier: 0.2, constant: 0),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 0)
        ])
        bottomViewConstraints.addConstraints()
        
        bottomView.addSubview(newsSourceLogo)
        let newsSourceLogoConstraints = Constraints(childView: newsSourceLogo, parentView: bottomView, constraints: [
            Constraint(constraintType: .vertical, multiplier: 1, constant: 0),
            Constraint(constraintType: .leading, multiplier: 1, constant: 20),
            Constraint(constraintType: .top, multiplier: 1, constant: 10),
            Constraint(constraintType: .aspectRatio, multiplier: (1.0/1.0), constant: 0)
        ])
        newsSourceLogoConstraints.addConstraints()
        
        bottomView.addSubview(sourceInfoStackView)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: sourceInfoStackView, attribute: .leading, relatedBy: .equal, toItem: newsSourceLogo, attribute: .trailing, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: sourceInfoStackView, attribute: .height, relatedBy: .equal, toItem: newsSourceLogo, attribute: .height, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: bottomView, attribute: .trailing, relatedBy: .equal, toItem: sourceInfoStackView, attribute: .trailing, multiplier: 1, constant: 20)
        ])
        let sourceInfoStackViewConstraints = Constraints(childView: sourceInfoStackView, parentView: bottomView, constraints: [
            Constraint(constraintType: .vertical, multiplier: 1, constant: 0)
        ])
        sourceInfoStackViewConstraints.addConstraints()
    }
    
    func setContainerViewConstraints(leftAnchor: CGFloat, rightAnchor: CGFloat, topAnchor: CGFloat, bottomAnchor: CGFloat){
        containerViewLeadingConstraint.constant = leftAnchor
        containerViewTrailingConstraint.constant = rightAnchor
        containerViewTopConstraint.constant = topAnchor
        containerViewBottomConstraint.constant = bottomAnchor
    }
    
    func shadow(action: ShadowAction){
        switch action {
        case .add:
            shadowView.layer.cornerRadius = 20
            shadowView.layer.shadowColor = UIColor.black.cgColor
            shadowView.layer.shadowOpacity = 0.2
            shadowView.layer.shadowRadius = 10
            shadowView.layer.shadowOffset = CGSize(width: -1, height: 2)
        case .remove:
            shadowView.layer.shadowColor = UIColor.clear.cgColor
            shadowView.layer.shadowOpacity = 0
            shadowView.layer.shadowRadius = 0
            shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        }
    }
    
    func updateLayout(for viewMode: CardMode) {
        switch viewMode {
        case .card:
            setContainerViewConstraints(leftAnchor: 20, rightAnchor: -20, topAnchor: 15, bottomAnchor: -15)
            shadow(action: .add)
        case .full:
            setContainerViewConstraints(leftAnchor: 0, rightAnchor: 0, topAnchor: 0, bottomAnchor: 0)
            shadow(action: .remove)
        }
    }
    
    func configure(with article: Article) {
        self.article = article
        setupBackgroundImage()
        setupTitle()
    }
    
    func hide(views: [UIView]) {
        views.forEach{ $0.removeFromSuperview() }
    }
    
    func show(views: [UIView]) {
        views.forEach{ $0.isHidden = false }
    }
}
