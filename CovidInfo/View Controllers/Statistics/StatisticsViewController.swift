//
//  StatisticsViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 12.05.2022.
//

import UIKit
import BetterSegmentedControl
import CoreData

var month: String?
var manualHistoricData: HistoricalData?

class StatisticsViewController: UIViewController {
    
    @Published var currentData: CurrentData?
    @Published var historicData: HistoricData?
    
    lazy var locationNotSelected: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "locationRestricted")!
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var yearCategories: BetterSegmentedControl = {
        let regularFont = UIFont(name: "IBMPLexSans-Regular", size: 14)!
        let categories = BetterSegmentedControl(frame: .zero, segments: LabelSegment.segments(withTitles: ["2022", "2021", "2020"], normalFont: regularFont, normalTextColor: .black, selectedFont: regularFont ,selectedTextColor: .white), options: [.backgroundColor(.white), .indicatorViewBackgroundColor(.black), .cornerRadius(16), .animationSpringDamping(1.0)])
        categories.addTarget(self, action: #selector(mainCategoriesTapped(_:)), for: .valueChanged)
        return categories
    }()
    
    lazy var mainCategories: BetterSegmentedControl = {
        let regularFont = UIFont(name: "IBMPLexSans-Regular", size: 14)!
        let categories = BetterSegmentedControl(frame: .zero, segments: LabelSegment.segments(withTitles: ["Actual", "Pe luna"], normalFont: regularFont, normalTextColor: .black, selectedFont: regularFont ,selectedTextColor: .white), options: [.backgroundColor(.white), .indicatorViewBackgroundColor(.black), .cornerRadius(16), .animationSpringDamping(1.0)])
        categories.addTarget(self, action: #selector(mainCategoriesTapped(_:)), for: .valueChanged)
        return categories
    }()
    
    lazy var months: BetterSegmentedControl = {
        let regularFont = UIFont(name: "IBMPLexSans-Regular", size: 14)!
        let categories = BetterSegmentedControl(frame: .zero, segments: LabelSegment.segments(withTitles: ["Ianuarie", "Februarie", "Martie", "Mai","Aprilie", "Iunie", "Iulie", "August", "Septembrie", "Octombrie", "Noiembrie", "Decembrie"], normalFont: regularFont, normalTextColor: .black, selectedFont: regularFont ,selectedTextColor: .white), options: [.backgroundColor(.white), .indicatorViewBackgroundColor(.black), .cornerRadius(16), .animationSpringDamping(1.0)])
        categories.addTarget(self, action: #selector(monthsTapped(_:)), for: .valueChanged)
        return categories
    }()
    
    lazy var monthsScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isHidden = true
        scrollView.addSubview(months)
        let categoriesConstraints = Constraints(childView: months, parentView: scrollView, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 15),
            Constraint(constraintType: .trailing, multiplier: 1, constant: 15),
            Constraint(constraintType: .top, multiplier: 1, constant: 0),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 0)
        ])
        categoriesConstraints.addConstraints()
        
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        return scrollView
    }()
    
    lazy var todaysCharts: UIView = {
        let view = UIView()
        self.addSubSwiftUIView(TodaysCharts(currentData: currentData!, historicData: historicData!), to: view)
        return view
    }()
    
    var historicCharts: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor("#efeff0")
        month = "Ianuarie"
        delegates.statistics = self
        setup()
    }
    
    func setup(){
        let automaticCountry: Bool = (AppDelegate.locationCountry != nil)
        let manualCountry: Bool = (defaults.string(forKey: "manualCountry") != nil)
        
        if automaticCountry == false && manualCountry == false{
            view.addSubview(locationNotSelected)
            
            let locationNotSelectedConstraints = Constraints(childView: locationNotSelected, parentView: view, constraints: [
                Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
                Constraint(constraintType: .vertical, multiplier: 1, constant: 0),
                Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
                Constraint(constraintType: .aspectRatio, multiplier: (1.0 / 1.0), constant: 0)
            ])
            locationNotSelectedConstraints.addConstraints()
        }
        
        if automaticCountry || manualCountry{
            currentData = defaults.bool(forKey: "automaticLocation") ? delegates.launch.getCurrentCountry(name: AppDelegate.locationCountry!): delegates.launch.getCurrentCountry(name: defaults.string(forKey: "manualCountry")!)
            historicData = defaults.bool(forKey: "automaticLocation") ? delegates.launch.getHistoricCountry(name: AppDelegate.locationCountry!): delegates.launch.getHistoricCountry(name: defaults.string(forKey: "manualCountry")!)
            manualHistoricData = defaults.bool(forKey: "automaticLocation") ? getManualHistoricCountry(name: AppDelegate.locationCountry!): getManualHistoricCountry(name: defaults.string(forKey: "manualCountry")!)
            
            contentSetup()
        }
    }
    
    func contentSetup(){
        
        historicCharts = UIView()
        self.addSubSwiftUIView(HistoricCharts(), to: historicCharts!)
        historicCharts?.isHidden = true
        
        view.addSubviews(views: [yearCategories, mainCategories, todaysCharts, monthsScrollView, historicCharts!])
        
        let yearCategoriesConstraints = Constraints(childView: yearCategories, parentView: view, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 12),
            Constraint(constraintType: .trailing, multiplier: 1, constant: -12),
            Constraint(constraintType: .top, multiplier: 1, constant: 10),
            Constraint(constraintType: .height, multiplier: 1, constant: 30)
        ])
        yearCategoriesConstraints.addConstraints()
        
        let categoriesConstraints = Constraints(childView: mainCategories, parentView: view, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 12),
            Constraint(constraintType: .trailing, multiplier: 1, constant: -12),
            Constraint(constraintType: .height, multiplier: 1, constant: 30)
        ])
        categoriesConstraints.addConstraints()
        mainCategories.topAnchor.constraint(equalTo: yearCategories.bottomAnchor, constant: 10).isActive = true
        
        let todaysChartsConstraints = Constraints(childView: todaysCharts, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 0)
        ])
        todaysChartsConstraints.addConstraints()
        todaysCharts.topAnchor.constraint(equalTo: mainCategories.bottomAnchor, constant: 10).isActive = true
        
        let monthsScrollViewConstraints = Constraints(childView: monthsScrollView, parentView: view, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 0),
            Constraint(constraintType: .trailing, multiplier: 1, constant: 0),
            Constraint(constraintType: .height, multiplier: 1, constant: 30),
        ])
        monthsScrollViewConstraints.addConstraints()
        monthsScrollView.topAnchor.constraint(equalTo: mainCategories.bottomAnchor, constant: 10).isActive = true
        
        let historicChartsConstraints = Constraints(childView: historicCharts!, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 0)
        ])
        historicChartsConstraints.addConstraints()
        historicCharts!.topAnchor.constraint(equalTo: monthsScrollView.bottomAnchor, constant: 10).isActive = true
    }
    
    func updateByMonth(){
        historicCharts!.removeFromSuperview()
        
        historicCharts = UIView()
        self.addSubSwiftUIView(HistoricCharts(), to: historicCharts!)
        historicCharts?.isHidden = false
        view.addSubview(historicCharts!)
        
        let historicChartsConstraints = Constraints(childView: historicCharts!, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 0)
        ])
        historicChartsConstraints.addConstraints()
        historicCharts!.topAnchor.constraint(equalTo: monthsScrollView.bottomAnchor, constant: 10).isActive = true
    }
    
    @objc func yearCategoriesTapped(_ sender: BetterSegmentedControl){
        switch sender.index {
        case 0:
            historicManualData = parseHistoricalData()
        case 1:
            historicManualData = parseOldHistoricalData(json: .date2021)
        case 2:
            historicManualData = parseOldHistoricalData(json: .date2020)
        default:
            ()
        }
    }
    
    @objc func mainCategoriesTapped(_ sender: BetterSegmentedControl){
        switch sender.index {
        case 0:
            monthsScrollView.isHidden = true
            historicCharts!.isHidden = true
            todaysCharts.isHidden = false
        case 1:
            todaysCharts.isHidden = true
            monthsScrollView.isHidden = false
            historicCharts!.isHidden = false
        default: ()
        }
    }
    
    @objc func monthsTapped(_ sender: BetterSegmentedControl){
        switch sender.index {
            case 0:
                month = "Ianuarie"
            case 1:
                month = "Februarie"
            case 2:()
                month = "Matie"
            case 3:()
                month = "Aprilie"
            case 4:()
                month = "Mai"
            case 5:()
                month = "Iunie"
            case 6:()
                month = "Iulie"
            case 7:()
                month = "August"
            case 8:()
                month = "Septembrie"
            case 9:()
                month = "Octombrie"
            case 10:()
                month = "Noiembrie"
            case 11:
                month = "Decembrie"
            default: ()
        }
        
        updateByMonth()
    }
}

extension StatisticsViewController: StatisticsViewControllerDelegate {
    func setupCountry(){
        if locationNotSelected.isDescendant(of: view){
            locationNotSelected.removeFromSuperview()
        }
        
        setup()
    }
    
    func contentViewVisibility(visibility: Bool){
        locationNotSelected.isHidden = visibility
    }
}

extension StatisticsViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.y = 0.0
    }
}
