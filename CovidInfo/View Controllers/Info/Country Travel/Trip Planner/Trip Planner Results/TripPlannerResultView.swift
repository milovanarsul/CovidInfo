//
//  TripPlannerResultView.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 29.05.2022.
//

import Foundation
import UIKit
import Lottie

class TripPlannerResultView: UIView{
    
    var arrivalData: [CountryTravelModel]?
    var departureData: [CountryTravelModel]?
    
    lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var departureResult: UIView = {
        let view = resultView(country: departureCountry!.name!, resultType: .departure)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var arrivalResult: UIView = {
        let view = resultView(country: arrivalCountry!.name!, resultType: .arrival)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    var departureResultHeightConstraint = NSLayoutConstraint()
    var departureResultTopConstraint = NSLayoutConstraint()
    var arrivalResultHeightConstraint =  NSLayoutConstraint()
    
    init(arrivalData: [CountryTravelModel], departureData: [CountryTravelModel]){
        self.arrivalData = arrivalData
        self.departureData = departureData
        super.init(frame: .zero)
        
        delegates.tripResult = self
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup(){
        addSubview(contentView)
        
        let contentViewConstraints = Constraints(childView: contentView, parentView: self, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 0),
            Constraint(constraintType: .top, multiplier: 1, constant: 0)
        ])
        contentViewConstraints.addConstraints()
        
        contentView.addSubviews(views: [departureResult, arrivalResult])
        
        let departureResultConstraints = Constraints(childView: departureResult, parentView: contentView, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
        ])
        departureResultConstraints.addConstraints()
        departureResultTopConstraint = departureResult.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10)
        departureResultHeightConstraint = departureResult.heightAnchor.constraint(equalToConstant: 340)
        departureResultTopConstraint.isActive = true
        departureResultHeightConstraint.isActive = true
        
        let arrivalResultConstraints = Constraints(childView: arrivalResult, parentView: contentView, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0)
        ])
        arrivalResultConstraints.addConstraints()
        arrivalResult.topAnchor.constraint(equalTo: departureResult.bottomAnchor, constant: 10).isActive = true
        arrivalResultHeightConstraint = arrivalResult.heightAnchor.constraint(equalToConstant: 340)
        arrivalResultHeightConstraint.isActive = true
    }
    
    func resultView(country: String, resultType: TripViewType) -> UIView{
        let data = DataManager.getCurrentCountry(name: country)
        let tripPlannerCountryResultView: UIView?
        
        switch resultType {
        case .arrival:
            tripPlannerCountryResultView = TripPlannerCountryResultView(countryTravelData: arrivalData!, data: data, resultType: resultType)
        case .departure:
            tripPlannerCountryResultView = TripPlannerCountryResultView(countryTravelData: departureData!, data: data, resultType: resultType)
        }
        
        return tripPlannerCountryResultView!
    }
    
    var resetDepartureTopConstraint = false
}

extension TripPlannerResultView: TripPlannerResultViewDelegate {
    func extendResult(resultType: TripViewType, height: CGFloat){
        
        switch resultType {
        case .arrival:
            
            if resetDepartureTopConstraint{
                departureResultTopConstraint.constant = 10
                resetDepartureTopConstraint = false
            } else {
                departureResultTopConstraint.constant = -350
                resetDepartureTopConstraint = true
            }

            arrivalResultHeightConstraint.constant = height
            
            UIView.animate(withDuration: 0.4, animations: {
                self.arrivalResult.layoutIfNeeded()
                self.layoutIfNeeded()
            })
            
        case .departure:
            departureResultHeightConstraint.constant = height
            
            UIView.animate(withDuration: 0.4, animations: {
                self.departureResult.layoutIfNeeded()
                self.layoutIfNeeded()
            })
        }

    }
}
