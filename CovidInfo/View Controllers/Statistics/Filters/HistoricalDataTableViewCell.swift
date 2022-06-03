//
//  HistoricalDataTableViewCell.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 03.06.2022.
//

import UIKit

class HistoricalDataTableViewCell: UITableViewCell {
    
    @Published var historic2022Data: HistoricalData?
    @Published var historic2021Data: OldHistoricalData?
    @Published var historic2020Data: OldHistoricalData?
    
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
    
    func setup(){
        contentView.addSubview(chartView)
        
        let chartViewConstraints = Constraints(childView: chartView, parentView: contentView, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .top, multiplier: 1, constant: 10),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 0)
        ])
        chartViewConstraints.addConstraints()
    }

}
