//
//  HistoricalDataTableViewCell.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 03.06.2022.
//

import UIKit

class HistoricalDataTableViewCell: UITableViewCell {
    
    @Published var historic2022Data: HistoricData?
    @Published var historic2021Data: Old2021HistoricData?
    @Published var historic2020Data: Old2020HistoricData?
    
    var parentViewController: UIViewController?
    
    lazy var chartView: UIView = {
        let view = UIView()
        
        switch year {
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
        defaultConstraints(childView: chartView, parentView: contentView)
    }

}
