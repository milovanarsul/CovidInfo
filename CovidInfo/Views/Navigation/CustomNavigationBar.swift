//
//  CustomNavigationBar.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 28.01.2022.
//

import UIKit

class CustomNavigationBar: UIView {
    
    lazy var childPageButton: UIButton = {
        let button = UIButton()
        button.initialize(title: "", titleColor: .black, cornerRadius: 0, font: boldFont(size: 30), backgroundColor: .white)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var parentPageButton: UIButton = {
        let button = UIButton()
        button.initialize(title: "", titleColor: .black, cornerRadius: 0, font: boldFont(size: 30), backgroundColor: .white, contentInsets: NSDirectionalEdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 0))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(goToMainView(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var certifficateButton: UIButton = {
        let button = UIButton()
        button.initialize(title: "", titleColor: .white, cornerRadius: 100, font: boldFont(size: 30), backgroundColor: signatureDarkBlue, contentInsets: NSDirectionalEdgeInsets(), image: UIImage(systemName: "qrcode.viewfinder"))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(certifficateButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var locationButton: UIView = {
        lazy var flagAndName: UIView = {
            let currentCountry = countryToISO(country: DataManager.currentCountry!, dictionary: roISOCountries)
            
            lazy var flagImageView: UIImageView = {
                let imageView = UIImageView()
                imageView.image = UIImage(named: currentCountry!)!
                imageView.contentMode = .scaleAspectFill
                imageView.layer.cornerRadius = 13
                imageView.clipsToBounds = true
                imageView.tag = 1
                imageView.tintColor = .white
                return imageView
            }()
            
            lazy var countryName: UILabel = {
                let label = UILabel()
                label.initialize(text: currentCountry!, color: .black, font: boldFont(size: 16), alignment: .center, lines: 1)
                label.translatesAutoresizingMaskIntoConstraints = false
                label.tag = 2
                return label
            }()
            
            let view = UIView()
            view.addSubviews(views: [flagImageView, countryName])
            
            let flagImageViewConstraints = Constraints(childView: flagImageView, parentView: view, constraints: [
                Constraint(constraintType: .vertical, multiplier: 1, constant: 0),
                Constraint(constraintType: .leading, multiplier: 1, constant: 10),
                Constraint(constraintType: .proportionalHeight, multiplier: 0.6, constant: 0),
                Constraint(constraintType: .aspectRatio, multiplier: (1.0 / 1.0), constant: 0)
            ])
            flagImageViewConstraints.addConstraints()
            
            countryName.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            countryName.leadingAnchor.constraint(equalTo: flagImageView.trailingAnchor, constant: 5).isActive = true
            
            return view
        }()
        
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = yellowColor
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        
        view.addSubview(flagAndName)
        defaultConstraints(childView: flagAndName, parentView: view)
        
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(locationButtonTapped)))
        
        return view
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.addSubviews(views: [childPageButton, parentPageButton, locationButton, certifficateButton])
        view.backgroundColor = .white
        return view
    }()
    
    var parentPageButtonLeadingConstraint = NSLayoutConstraint()
    var childPageButtonLeadingConstraint = NSLayoutConstraint()
    var certifficateButtonTrailingConstraint = NSLayoutConstraint()
    var locationButtonTrailingConstraint = NSLayoutConstraint()
    var locationButtonWidthConstraint = NSLayoutConstraint()
    var containerViewBottomConstraint = NSLayoutConstraint()
    
    func setup(){
        addSubview(containerView)
                
        let containerViewConstraints = Constraints(childView: containerView, parentView: self, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .height, multiplier: 1, constant: 60),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 0)
        ])
        containerViewConstraints.addConstraints()
        
        parentPageButtonLeadingConstraint = parentPageButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor)
        childPageButtonLeadingConstraint = childPageButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: -300)
        NSLayoutConstraint.activate([parentPageButtonLeadingConstraint, childPageButtonLeadingConstraint])
        childPageButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        parentPageButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        
        let certifficateButtonConstraints = Constraints(childView: certifficateButton, parentView: containerView, constraints: [
            Constraint(constraintType: .vertical, multiplier: 1, constant: 0),
            Constraint(constraintType: .width, multiplier: 1, constant: 40),
            Constraint(constraintType: .height, multiplier: 1, constant: 40),
        ])
        certifficateButtonConstraints.addConstraints()
        certifficateButtonTrailingConstraint = certifficateButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 70)
        certifficateButtonTrailingConstraint.isActive = true
        
        let locationButtonConstraints = Constraints(childView: locationButton, parentView: containerView, constraints: [
            Constraint(constraintType: .vertical, multiplier: 1, constant: 0),
            Constraint(constraintType: .height, multiplier: 1, constant: 40)
        ])
        locationButtonConstraints.addConstraints()
        locationButtonWidthConstraint = locationButton.widthAnchor.constraint(equalToConstant: 40)
        locationButtonTrailingConstraint = locationButton.leadingAnchor.constraint(equalTo: certifficateButton.leadingAnchor, constant: 0)
        NSLayoutConstraint.activate([locationButtonWidthConstraint, locationButtonTrailingConstraint])
    }
    
    func slideOutParentPageButton(){
        parentPageButtonLeadingConstraint.constant = -parentButtonLeading
        makeChildToParent()
        
        UIView.animate(withDuration: defaultNavigationAnimation, animations: {
            self.parentPageButton.layoutIfNeeded()
            self.layoutIfNeeded()
        }, completion: {(finished: Bool) in
            self.parentPageButton.isHidden = true
            self.parentPageButtonLeadingConstraint.constant = 0
        })
    }
    
    func makeChildToParent(){
        childPageButtonLeadingConstraint.constant = -parentButtonLeading
        
        UIView.animate(withDuration: defaultNavigationAnimation, animations: {
            self.childPageButton.layoutIfNeeded()
            self.layoutIfNeeded()
        }, completion: {(finished: Bool) in
            self.childPageButton.isHidden = true
            self.parentPageButton.isHidden = false
            self.slideInChildPageButton()
        })
    }
    
    func slideOutChildPageButton(){
        childPageButtonLeadingConstraint.constant = -200
        
        UIView.animate(withDuration: defaultNavigationAnimation, animations: {
            self.childPageButton.layoutIfNeeded()
            self.layoutIfNeeded()
        }, completion: {(finished: Bool) in
            self.childPageButton.isHidden = true
            self.childPageButtonLeadingConstraint.constant = 25
        })
    }
    
    func slideInChildPageButton(){
        childPageButton.isHidden = false
        childPageButtonLeadingConstraint.constant = getParentPageButtonWidth() + 0
        
        UIView.animate(withDuration: defaultNavigationAnimation, animations: {
            self.childPageButton.layoutIfNeeded()
            self.layoutIfNeeded()
        })
    }
    
    private var parentPageTitle: String?
    private var childPageTitle: String?
    private var showChildButton: Bool?
    var resetsLocationButton: Bool = false
    
    func getParentPageButtonWidth() -> CGFloat{
        return parentPageButton.bounds.width
    }
    
    @objc func goToMainView(_ sender: UIButton) {
        buttonSlider(sliderType: .left)
        delegates.homePage.goToPage(pageIndex:0, direction: .reverse)
        delegates.main.tabBarVisibility(tabBarVisibility: .show)
        delegates.main.certifficateButtonAnimation(visibility: .show)
    }
    
    @objc func certifficateButtonTapped(_ sender: UIButton) {
        defaults.bool(forKey: "certifficateEnrolled") ? delegates.main.certifficateModal() : delegates.main.enrollCertifficate()
    }
    
    @objc func locationButtonTapped(){
        let pageControllerIndex = delegates.tabBar.getCurrentIndex()
        let automaticLocation = defaults.bool(forKey: "useAutomaticLocation")
        let currentCountry = countryToISO(country: DataManager.currentCountry!, dictionary: roISOCountries)
        
        switch resetsLocationButton{
        case false:
            if automaticLocation{
                delegates.main.animateContentView(size: 65)
            } else {
                delegates.main.contentViewVisibility(visibility: .hide)
                delegates.main.animateContentView(size: 650)
            }
            
            switch pageControllerIndex{
            case 0:
                ()
            case 1:
                delegates.main.planTripButtonAnimation(visibility: .hide)
            case 2:
                ()
            case 3:
                delegates.main.statisticsActionsAnimation(visibility: .hide)
            default:
                ()
            }
            
            (locationButton.viewWithTag(1) as! UIImageView).image = UIImage(systemName: "x.circle")
            (locationButton.viewWithTag(2) as! UILabel).initialize(text: "Inchide", color: .white, font: boldFont(size: 16), alignment: .center, lines: 1)
            locationButtonTapExtend(visbility: .show)
            locationButton.backgroundColor = redColor
            resetsLocationButton = true
        case true:
            delegates.main.animateContentView(size: 5)
            
            switch pageControllerIndex{
            case 0:
                ()
            case 1:
                delegates.main.planTripButtonAnimation(visibility: .show)
            case 2:
                ()
            case 3:
                delegates.main.countryPickerActionsAnimaiton(visibility: .hide)
                delegates.main.statisticsActionsAnimation(visibility: .show)
            default:
                ()
            }
            
            (locationButton.viewWithTag(1) as! UIImageView).image = UIImage(named: currentCountry!)!
            (locationButton.viewWithTag(2) as! UILabel).initialize(text: currentCountry!, color: .black, font: boldFont(size: 16), alignment: .center, lines: 1)
            locationButtonTapExtend(visbility: .hide)
            delegates.main.countryPickerActionsAnimaiton(visibility: .hide)
            locationButton.backgroundColor = yellowColor
            delegates.main.contentViewVisibility(visibility: .show)
            resetsLocationButton = false
            delegates.countryPicker.hideKeyboard()
        }
    }
    
    func locationButtonTapExtend(visbility: ViewVisibility){
        switch visbility {
        case .show:
            locationButtonWidthConstraint.constant = 110
            locationButtonTrailingConstraint.constant = -120
        case .hide:
            locationButtonWidthConstraint.constant = 80
            locationButtonTrailingConstraint.constant = -90
        }
        
        UIView.animate(withDuration: 0.6, animations: {
            self.locationButton.layoutIfNeeded()
            self.layoutIfNeeded()
        })
    }
}

extension CustomNavigationBar{
    
    func changeChildPageButton(title: String) {
        childPageButton.setAttributedTitle(setNSMutableString(title: title, font: boldFont(size: 30), foregroundColor: .black), for: .normal)
        childPageButton.backgroundColor = .clear
    }
    
    func changeParentPageButton(title: String) {
        parentPageButton.setAttributedTitle(setNSMutableString(title: title, font: boldFont(size: 30), foregroundColor: .black), for: .normal)
        parentPageButton.backgroundColor = .clear
    }
    
    func currentPageSettings(){
        changeParentPageButton(title: parentPageTitle!)
        
        if childPageTitle != nil{
            changeChildPageButton(title: childPageTitle!)
        }
        
        childPageButton.isHidden = !showChildButton!
    }
}

extension CustomNavigationBar: NavigationBarDelegate{
    func setup(page: Page) {
        parentPageTitle = page.getParentPage()
        
        if page.childType != ChildPages.none {
            childPageTitle = page.getChildPage()
            showChildButton = true
        } else {
            showChildButton = false
        }
        currentPageSettings()
    }
    
    func buttonSlider(sliderType: currentPageButtonSlider) {
        switch sliderType {
        case .left:
            slideOutChildPageButton()
        case .right:
            slideInChildPageButton()
        case .hideParent:
            slideOutParentPageButton()
        }
    }
    
    func certifficateButtonAnimation(visibility: ViewVisibility){
        switch visibility {
        case .show:
            certifficateButton.isHidden = false
            certifficateButtonTrailingConstraint.constant = -20
        case .hide:
            certifficateButtonTrailingConstraint.constant = 70
        }
        
        UIView.animate(withDuration: 0.6, animations: {
            self.certifficateButton.layoutIfNeeded()
            self.layoutIfNeeded()
        }, completion: {(finished: Bool) in
            if visibility == .hide{
                self.certifficateButton.isHidden = true
            }
        })
    }
    
    func locationButtonAnimation(visibility: ViewVisibility){
        switch visibility {
        case .show:
            locationButton.isHidden = false
            locationButtonTrailingConstraint.constant = -90
            locationButtonWidthConstraint.constant = 80
        case .hide:
            locationButtonWidthConstraint.constant = 40
            locationButtonTrailingConstraint.constant = 0
        }
        
        UIView.animate(withDuration: 0.6, animations: {
            self.locationButton.layoutIfNeeded()
            self.layoutIfNeeded()
        }, completion: {(finished: Bool) in
            if visibility == .hide{
                self.locationButton.isHidden = true
            }
        })
    }
    
    func locationButtonContentAnimation(visibility: ViewVisibility){
        let duration: TimeInterval?
        
        switch visibility {
        case .show:
            locationButtonTrailingConstraint.constant = -90
            locationButtonWidthConstraint.constant = 80
            duration = 0.4
        case .hide:
            locationButtonTrailingConstraint.constant = -50
            locationButtonWidthConstraint.constant = 40
            duration = 0
        }
        
        UIView.animate(withDuration: duration!, animations: {
            self.locationButton.layoutIfNeeded()
        })
    }
    
    func changeContainerViewBottomConstraint(visibility: Bool){
        containerView.isHidden = visibility
    }
    
    func simulateLocationButtonTap(viewVisibility: ViewVisibility){
        switch viewVisibility {
        case .show:
            resetsLocationButton = false
            locationButtonTapped()
        case .hide:
            resetsLocationButton = true
            locationButtonTapped()
        }
    }
}
