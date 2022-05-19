//
//  FirstCategory.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 19.05.2022.
//

import UIKit

class FirstCategory: UIView {
    
    var parentViewController: UIViewController?
    @Published var currentData: CurrentData?
    @Published var historicData: HistoricData?
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var lastUpdatedOn: UILabel = {
        let label = UILabel()
        label.initialize(text: "Ultima actualizare: " + (currentData?.last_updated_date)!, color: .black, font: UIFont(name: "IBMPlexSans-Regular", size: 14)!, alignment: .center, lines: 0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var todaysData: UIView = {
        let view = UIView()
        parentViewController!.addSubSwiftUIView(TodayData(currentData: currentData!, historicData: historicData!), to: view)
        return view
    }()
    
    lazy var totalData: UIStackView = {
        let totalCases = componentView(tile: "Cazuri totale", content: currentData!.total_cases)
        let totalDeaths = componentView(tile: "Decese totale", content: currentData!.total_deaths)
        let totalCasesPerMillion = componentView(tile: "Cazuri totale per milion", content: currentData!.total_cases_per_million)
        let totalDeathsPerMillion = componentView(tile: "Decese totale per milion", content: currentData!.total_deaths_per_million)
        let totalTests = componentView(tile: "Teste totale", content: currentData!.total_tests)
        let totalTestsPerThousand = componentView(tile: "Teste totale per mia de locuitori", content: currentData!.total_tests_per_thousand)
        let totalVaccinations = componentView(tile: "Vaccinari totale", content: currentData!.total_vaccinations)
        let totalVaccinationsPerHundred = componentView(tile: "Vaccinari totale per suta de locuitori", content: currentData!.total_vaccinations_per_hundred)
        let totalBoosters = componentView(tile: "Boostere totale", content: currentData!.total_boosters)
        let totalBoostersPerHundred = componentView(tile: "Boostere totale per suta de locuitori", content: currentData!.total_boosters_per_hundred)
        
        let totalDataArray: [(UIView, UIView)] = [
            (totalCases, totalDeaths), (totalCasesPerMillion, totalDeathsPerMillion), (totalTests, totalTestsPerThousand), (totalVaccinations, totalVaccinationsPerHundred), (totalBoosters, totalBoostersPerHundred)
        ]
        
        let stackView = componentVerticalStackView(stackViews: totalDataArray)
        return stackView
    }()
    
    func setup(){
        addSubview(scrollView)
        defaultAutoResizingMask(childView: scrollView, parentView: self, width: false)
        scrollView.addSubview(contentView)
        defaultAutoResizingMask(childView: contentView, parentView: scrollView, width: true)
        
        contentView.addSubviews(views: [lastUpdatedOn, totalData])
        
        let lastUpdatedOnConstraints = Constraints(childView: lastUpdatedOn, parentView: contentView, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .top, multiplier: 1, constant: 10)
        ])
        lastUpdatedOnConstraints.addConstraints()
        
        /*
        let todaysDataConstraints = Constraints(childView: todaysData, parentView: contentView, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 12),
            Constraint(constraintType: .trailing, multiplier: 1, constant: -12),
            Constraint(constraintType: .height, multiplier: 1, constant: 240)
        ])
        todaysDataConstraints.addConstraints()
        todaysData.topAnchor.constraint(equalTo: lastUpdatedOn.bottomAnchor, constant: 10).isActive = true
        */
        
        let totalDataConstraints = Constraints(childView: totalData, parentView: contentView, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 12),
            Constraint(constraintType: .trailing, multiplier: 1, constant: -12),
            Constraint(constraintType: .height, multiplier: 1, constant: 640)
        ])
        totalDataConstraints.addConstraints()
        totalData.topAnchor.constraint(equalTo: lastUpdatedOn.bottomAnchor, constant: 10).isActive = true
    }
    
    init(parentViewController: UIViewController, currentData: CurrentData, historicData: HistoricData){
        self.parentViewController = parentViewController
        self.currentData = currentData
        self.historicData = historicData
        super.init(frame: .zero)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
