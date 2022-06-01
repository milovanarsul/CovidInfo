//
//  InfoViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 25.04.2022.
//

import UIKit
import Firebase
import BetterSegmentedControl

class InfoViewController: UIViewController {
    
    var infoCardsDataArray: [InfoCardsData]?
    
    lazy var categories: BetterSegmentedControl = {
        let categories = BetterSegmentedControl(frame: .zero,
                                                segments: LabelSegment.segments(withTitles: ["Calatorie","Intrebari frecvente", "Vaccinare", "Variante"], normalFont: boldFont(size: 14), normalTextColor: .black, selectedFont: boldFont(size: 14) ,selectedTextColor: .white),
                                                options: [.backgroundColor(.clear), .indicatorViewBackgroundColor(signatureLightBlue), .cornerRadius(16), .animationSpringDamping(1.0),])
        categories.segmentPadding = 2.0
        categories.panningDisabled = true
        categories.addTarget(self, action: #selector(categoriesTapped(_:)), for: .valueChanged)
        return categories
    }()
    
    lazy var categoriesScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.addSubview(categories)
        let categoriesConstraints = Constraints(childView: categories, parentView: scrollView, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 15),
            Constraint(constraintType: .trailing, multiplier: 1, constant: -15),
            Constraint(constraintType: .top, multiplier: 1, constant: 0),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 0)
        ])
        categoriesConstraints.addConstraints()
        
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = UIColor("#f2f2f7")
        
        return scrollView
    }()
    
    lazy var infoPageViewController: UIView = {
        let view = UIView()
        embed.infoPageViewController(parent: self, container: view)
        return view
    }()
    
    var currentIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegates.info = self
        setup()
    }
    
    func setup(){
        view.layer.cornerRadius = 24
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor("#f2f2f7")
        
        view.addSubviews(views: [categoriesScrollView, infoPageViewController])
                
        let categoriesScrollViewConstraints = Constraints(childView: categoriesScrollView, parentView: view, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 0),
            Constraint(constraintType: .trailing, multiplier: 1, constant: 0),
            Constraint(constraintType: .height, multiplier: 1, constant: 30),
            Constraint(constraintType: .top, multiplier: 1, constant: 15)
        ])
        categoriesScrollViewConstraints.addConstraints()
        
        let infoPageViewControllerConstraints = Constraints(childView: infoPageViewController, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 0)
        ])
        infoPageViewControllerConstraints.addConstraints()
        infoPageViewController.topAnchor.constraint(equalTo: categoriesScrollView.bottomAnchor, constant: 10).isActive = true
    }
    
    func categoriesActions(index: Int){
        var scrollDirection: UIPageViewController.NavigationDirection?
        
        if index < currentIndex {
            scrollDirection = .reverse
        } else {
            scrollDirection = .forward
        }
        
        switch index {
        case 0:
            delegates.infoPage.goToPage(pageIndex: 0, direction: scrollDirection!)
            delegates.main.planTripButtonAnimation(visibility: .show)
            delegates.navigationBar.locationButtonAnimation(visibility: .show)
        case 1:
            delegates.infoPage.goToPage(pageIndex: 1, direction: scrollDirection!)
            delegates.main.planTripButtonAnimation(visibility: .hide)
            delegates.navigationBar.locationButtonAnimation(visibility: .hide)
        case 2:
            delegates.infoPage.goToPage(pageIndex: 2, direction: scrollDirection!)
            delegates.main.planTripButtonAnimation(visibility: .hide)
            delegates.navigationBar.locationButtonAnimation(visibility: .hide)
        case 3:
            delegates.infoPage.goToPage(pageIndex: 3, direction: scrollDirection!)
            delegates.main.planTripButtonAnimation(visibility: .hide)
            delegates.navigationBar.locationButtonAnimation(visibility: .hide)
        default: ()
        }
        
        currentIndex = index
    }
    
    @objc func categoriesTapped(_ sender: BetterSegmentedControl){
        categoriesActions(index: sender.index)
    }
}

extension InfoViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.y = 0.0
    }
}

extension InfoViewController: InfoViewControllerDelegate{
    func getCardsViewController() -> UIViewController{
        return self.children[1]
    }
    
    func viewsVisibility(visibility: Bool){
        categoriesScrollView.isHidden = visibility
        infoPageViewController.isHidden = visibility
    }
    
    func setCategoriesIndex(index: Int){
        categories.setIndex(index)
        categoriesActions(index: index)
    }
}


