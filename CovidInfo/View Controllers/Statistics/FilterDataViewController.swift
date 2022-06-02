//
//  FilterDataViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 02.06.2022.
//

import UIKit
import MonthYearWheelPicker

var showFilterResetButton: Bool = false
var showHistoricData: Bool = false
var month: String?
var year: Int?

class FilterDataViewController: UIViewController {
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.initialize(text: "Selecteaza o data", color: .black, font: boldFont(size: 20), alignment: .left, lines: 0)
        return label
    }()
    
    lazy var datePicker: MonthYearWheelPicker = {
        let datePicker = MonthYearWheelPicker()
        datePicker.minimumDate = createDate(day: 1, month: 1, year: 2020)
        datePicker.maximumDate = Date()
        datePicker.date = Date()
        datePicker.backgroundColor = .clear
        datePicker.addTarget(self, action: #selector(monthYearWheelPickerDidChange), for: .valueChanged)
        return datePicker
    }()
    
    lazy var filterButton: UIButton = {
        let button = UIButton()
        button.initialize(title: "Filtreaza", titleColor: .white, cornerRadius: 24, font: boldFont(size: 13), backgroundColor: signatureDarkBlue, contentInsets: NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20), image: UIImage(systemName: "slider.vertical.3"))
        button.addTarget(self, action: #selector(filterButtonTapped(_:)), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    func setup(){
        view.addSubviews(views: [label, datePicker, filterButton])
        
        let labelConstraints = Constraints(childView: label, parentView: view, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 24),
            Constraint(constraintType: .trailing, multiplier: 1, constant: -24),
            Constraint(constraintType: .top, multiplier: 1, constant: 30)
        ])
        labelConstraints.addConstraints()
        
        let filterButtonConstraints = Constraints(childView: filterButton, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 25)
        ])
        filterButtonConstraints.addConstraints()
        
        defaultConstraints(childView: datePicker, parentView: view)
    }
    
    @objc func filterButtonTapped(_ sender: UIButton){
        showHistoricData = true
        delegates.statistics.refreshTableView()
        delegates.main.dimissModal(completion: {})
    }
    
    @objc func monthYearWheelPickerDidChange() {
        let date = Calendar.current.dateComponents([.year, .month], from: datePicker.date)
        month = romanianMonths[date.month!]
        year = date.year
    }
}
