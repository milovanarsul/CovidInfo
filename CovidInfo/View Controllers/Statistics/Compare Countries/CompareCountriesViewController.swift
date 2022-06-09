//
//  CompareCountriesViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 03.06.2022.
//

import UIKit
import BetterSegmentedControl

class CompareCountriesViewController: UIViewController {
    
    lazy var topBar: UIView = {
        lazy var redoResultButton: UIButton = {
            let button = UIButton()
            button.initialize(title: "Inapoi", titleColor: .black, cornerRadius: 0, font: boldFont(size: 18), backgroundColor: .clear, contentInsets: NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20), image: UIImage(systemName: "arrow.backward.circle.fill"))
            button.addTarget(self, action: #selector(redoResultTapped(_:)), for: .touchUpInside)
            button.isHidden = true
            button.tag = 2
            return button
        }()
        
        lazy var closeButton: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "darkOnLight")!
            imageView.contentMode = .scaleAspectFit
            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeButtonTapped)))
            imageView.isUserInteractionEnabled = true
            return imageView
        }()
        
        let view = UIView()
        view.backgroundColor = .white
        view.addSubviews(views: [redoResultButton, closeButton])
        
        let closeButtonConstraints = Constraints(childView: closeButton, parentView: view, constraints: [
            Constraint(constraintType: .trailing, multiplier: 1, constant: -24),
            Constraint(constraintType: .aspectRatio, multiplier: (1.0 / 1.0), constant: 0),
            Constraint(constraintType: .height, multiplier: 1, constant: 25),
            Constraint(constraintType: .top, multiplier: 1, constant: 20)
        ])
        closeButtonConstraints.addConstraints()
        
        let redoResultButtonConstraints = Constraints(childView: redoResultButton, parentView: view, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 12),
            Constraint(constraintType: .top, multiplier: 1, constant: 10)
        ])
        redoResultButtonConstraints.addConstraints()
        
        return view
    }()
    
    lazy var onboardingView: UIView = {
        lazy var onboardingImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "compareCountries")!
            imageView.contentMode = .scaleAspectFill
            return imageView
        }()
        
        lazy var locationButtons: UIStackView = {
            lazy var country1Button: UIButton = {
                let button = UIButton()
                button.initialize(title: "Selecteaza tara 1", titleColor: .white, cornerRadius: 8, font: boldFont(size: 18), backgroundColor: signatureDarkBlue, contentInsets: NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20), image: UIImage(systemName: "1.circle"))
                button.contentHorizontalAlignment = .left
                button.addTarget(self, action: #selector(country1Tapped(_:)), for: .touchUpInside)
                return button
            }()
            
            lazy var country2Button: UIButton = {
                let button = UIButton()
                button.initialize(title: "Selecteaza tara 2", titleColor: .white, cornerRadius: 8, font: boldFont(size: 18), backgroundColor: signatureDarkBlue, contentInsets: NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20), image: UIImage(systemName: "2.circle"))
                button.contentHorizontalAlignment = .left
                button.addTarget(self, action: #selector(country2Tapped(_:)), for: .touchUpInside)
                return button
            }()
            
            let stackView = UIStackView()
            stackView.initalize(axis: .vertical, alignment: .fill, distribution: .fillEqually, spacing: 20)
            stackView.addAranagedSubviews(views: [country1Button, country2Button])
            return stackView
        }()
        
        let view = UIView()
        view.addSubviews(views: [onboardingImageView, locationButtons])
        
        let onboardingImageViewConstraints = Constraints(childView: onboardingImageView, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 0.8, constant: 0),
            Constraint(constraintType: .top, multiplier: 1, constant: 50),
            Constraint(constraintType: .aspectRatio, multiplier: (1.0 / 1.0), constant: 0)
        ])
        onboardingImageViewConstraints.addConstraints()
        
        let locationButtonsConstraints = Constraints(childView: locationButtons, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 0.7, constant: 0),
            Constraint(constraintType: .proportionalHeight, multiplier: 0.15, constant: 0)
        ])
        locationButtonsConstraints.addConstraints()
        locationButtons.topAnchor.constraint(equalTo: onboardingImageView.bottomAnchor, constant: 30).isActive = true
        
        return view
    }()
    
    lazy var country1TableView: UIView = {
        let view = CompareCountriesPickerView(viewType: .country1)
        return view
    }()
    
    lazy var country2TableView: UIView = {
        let view = CompareCountriesPickerView(viewType: .country2)
        return view
    }()
    
    lazy var resultView: UIView = {
        lazy var countriesTitleResultView: BetterSegmentedControl = {
            let categories = BetterSegmentedControl(frame: .zero,
                                                    segments: LabelSegment.segments(withTitles: [country1!.name!, country2!.name!], normalFont: boldFont(size: 30), normalTextColor: .black, selectedFont: boldFont(size: 30) ,selectedTextColor: .black),
                                                    options: [.backgroundColor(.clear),
                                                              .indicatorViewBorderColor(.black),
                                                              .indicatorViewBorderWidth(2),
                                                              .indicatorViewInset(40),
                                                              .indicatorViewBackgroundColor(.clear), .cornerRadius(16), .animationSpringDamping(1.0),])
            categories.segmentPadding = 2.0
            categories.panningDisabled = true
            categories.addTarget(self, action: #selector(countryResultTitleTapped(_:)), for: .valueChanged)
            return categories
        }()
        
        lazy var pageViewController: UIView = {
            let view = UIView()
            embed.compareCountriesPageViewController(parent: self, container: view)
            return view
        }()
        
        let parentView = UIView()
        parentView.addSubviews(views: [countriesTitleResultView, pageViewController])
        
        let countriesTitlesResultViewConstraints = Constraints(childView: countriesTitleResultView, parentView: parentView, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .height, multiplier: 1, constant: 50),
            Constraint(constraintType: .top, multiplier: 1, constant: 0)
        ])
        countriesTitlesResultViewConstraints.addConstraints()
        
        let pageViewControllerConstraints = Constraints(childView: pageViewController, parentView: parentView, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 0)
        ])
        pageViewControllerConstraints.addConstraints()
        pageViewController.topAnchor.constraint(equalTo: countriesTitleResultView.bottomAnchor, constant: 10).isActive = true
        
        return parentView
        
    }()
    
    var screenWidth: CGFloat = UIScreen.main.bounds.width
    var country1BottomConstraint = NSLayoutConstraint()
    var country2BottomConstraint = NSLayoutConstraint()

    override func viewDidLoad() {
        super.viewDidLoad()

        delegates.compareCountries = self
        setup()
    }
     
    func setup(){
        view.addSubviews(views: [topBar, onboardingView, country1TableView, country2TableView])
        
        let topBarConstraints = Constraints(childView: topBar, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .top, multiplier: 1, constant: 0),
            Constraint(constraintType: .height, multiplier: 1, constant: 40)
        ])
        topBarConstraints.addConstraints()
        
        let onboardingViewConstraints = Constraints(childView: onboardingView, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 0),
        ])
        onboardingViewConstraints.addConstraints()
        onboardingView.topAnchor.constraint(equalTo: topBar.bottomAnchor, constant: 10).isActive = true
        
        let departureViewConstraints = Constraints(childView: country1TableView, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalHeight, multiplier: 0.7, constant: 0)
        ])
        departureViewConstraints.addConstraints()
        country1BottomConstraint = country1TableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: screenWidth * 2)
        country1BottomConstraint.isActive = true
        
        let arrivalViewConstraints = Constraints(childView: country2TableView, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalHeight, multiplier: 0.7, constant: 0)
        ])
        arrivalViewConstraints.addConstraints()
        country2BottomConstraint = country2TableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: screenWidth * 2)
        country2BottomConstraint.isActive = true
    }
    
    func animateLocationTableView(locationView: UIView, bottomConstraint: NSLayoutConstraint, visibility: ViewVisibility) {
        switch visibility {
        case .show:
            bottomConstraint.constant = 0
        case .hide:
            bottomConstraint.constant = screenWidth * 2
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            locationView.layoutIfNeeded()
            self.view.layoutIfNeeded()
        })
    }
    
    @objc func closeButtonTapped(){
        delegates.main.dimissModal(completion: {})
    }
    
    @objc func country1Tapped(_ sender: UIButton){
        animateLocationTableView(locationView: country1TableView, bottomConstraint: country1BottomConstraint, visibility: .show)
    }
    
    @objc func country2Tapped(_ sender: UIButton){
        animateLocationTableView(locationView: country2TableView, bottomConstraint: country2BottomConstraint, visibility: .show)
    }
    
    @objc func automaticButtonTapped(_ sender: UIButton){
        
    }
    
    @objc func redoResultTapped(_ sender: UIButton){
        view.viewWithTag(2)?.isHidden = true
        view.backgroundColor = .white
        topBar.backgroundColor = .white
        //resultTableView.removeFromSuperview()
        onboardingView.isHidden = false
        
        country1 = nil
        country2 = nil
    }
    
    @objc func countryResultTitleTapped(_ sender: BetterSegmentedControl){
        switch sender.index{
        case 0:
            delegates.compareCountriesPVC.goToPage(pageIndex: 0, direction: .reverse)
        case 1:
            delegates.compareCountriesPVC.goToPage(pageIndex: 1, direction: .forward)
        default:
            ()
        }
    }
}

extension CompareCountriesViewController: CompareCountries{
    func animateCountry1(){
        animateLocationTableView(locationView: country1TableView, bottomConstraint: country1BottomConstraint, visibility: .hide)
    }
    
    func animateCountry2(){
        animateLocationTableView(locationView: country2TableView, bottomConstraint: country2BottomConstraint, visibility: .hide)
    }
    
    func result(){
        onboardingView.isHidden = true
        view.backgroundColor = UIColor("#f2f2f7")
        topBar.backgroundColor = UIColor("#f2f2f7")
        
        view.addSubview(resultView)
        let resultViewConstraints = Constraints(childView: resultView, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 20),
        ])
        resultViewConstraints.addConstraints()
        resultView.topAnchor.constraint(equalTo: topBar.bottomAnchor, constant: 10).isActive = true
    }
}
