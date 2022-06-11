//
//  HistoricalDataTableViewCell.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 03.06.2022.
//

import UIKit

class HistoricalDataView: UIView {
    
    var historic2022Data: HistoricalData?
    var historic2021Data: OldHistoricalData?
    var historic2020Data: OldHistoricalData?
    var parentViewController: UIViewController?
    
    lazy var chartView: UIView = {
        let view = UIView()
        
        switch selectedYear {
        case 2022:
            parentViewController!.addSubSwiftUIView(Historic2022Charts(historicData: historic2022Data!), to: view)
        case 2021:
            parentViewController!.addSubSwiftUIView(Historic2021Charts(historicData: historic2021Data!), to: view)
        case 2020:
            parentViewController!.addSubSwiftUIView(Historic2020Charts(historicData: historic2020Data!), to: view)
        default: ()
        }
        
        return view
    }()
    
    init(historic2022Data: HistoricalData, historic2021Data: OldHistoricalData, historic2020Data: OldHistoricalData, parentViewController: UIViewController){
        self.historic2020Data = historic2020Data
        self.historic2021Data = historic2021Data
        self.historic2022Data = historic2022Data
        self.parentViewController = parentViewController
        
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup(){
        backgroundColor = UIColor("#efeff0")
        layer.cornerRadius = 24
        clipsToBounds = true
        addSubview(chartView)
        
        let chartViewConstraints = Constraints(childView: chartView, parentView: self, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .top, multiplier: 1, constant: 10),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 0)
        ])
        chartViewConstraints.addConstraints()
    }

}
