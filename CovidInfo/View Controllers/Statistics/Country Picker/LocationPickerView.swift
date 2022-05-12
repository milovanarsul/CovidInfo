//
//  LocationPickerView.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 11.05.2022.
//

import UIKit

class LocationPickerView: UIView {
    
    var location: String?
    var isLocationDisabled: Bool?
    
    lazy var mainLabel: UILabel = {
        let label = UILabel()
        let text = isLocationDisabled! ? "Locatie manuala" : "Locatie automata"
        label.initialize(text: text, color: .black, font: boldFont(size: 16), alignment: .left, lines: 0)
        return label
    }()
    
    lazy var desriptionLabel: UILabel = {
        let label = UILabel()
        label.initialize(text: location!, color: .gray, font: UIFont(name: "IBMPlexSans-Regular", size: 14)!, alignment: .left, lines: 0)
        return label
    }()
    
    lazy var locationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.initalize(axis: .vertical, alignment: .fill, distribution: .fillEqually, spacing: 5)
        stackView.addArrangedSubview(mainLabel)
        isLocationDisabled! ? () : stackView.addArrangedSubview(desriptionLabel)
        return stackView
    }()
    
    lazy var locationSwitch: UISwitch = {
        let locationSwitch = UISwitch()
        locationSwitch.onTintColor = signatureDarkBlue
        locationSwitch.preferredStyle = .sliding
        locationSwitch.isOn = !isLocationDisabled!
        locationSwitch.addTarget(self, action: #selector(switchAction), for: .valueChanged)
        return locationSwitch
    }()
    
    init(location: String){
        self.location = location
        super.init(frame: .zero)
        isLocationDisabled = locationDisabled()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup(){
        addSubviews(views: [locationStackView, locationSwitch])
        
        let locationStackViewConstraints = Constraints(childView: locationStackView, parentView: self, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 12),
            Constraint(constraintType: .vertical, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 0.7, constant: 0)
        ])
        locationStackViewConstraints.addConstraints()
        
        let locationSwitchConstraints = Constraints(childView: locationSwitch, parentView: self, constraints: [
            Constraint(constraintType: .vertical, multiplier: 1, constant: 0),
            Constraint(constraintType: .trailing, multiplier: 1, constant: -24)
        ])
        locationSwitchConstraints.addConstraints()
    }
    
    @objc func switchAction(sender: UISwitch!){
        if sender.isOn == false{
            delegates.main.animateContentView(size: 650)
            self.desriptionLabel.isHidden = true
            delegates.statistics.contentViewVisibility(visibility: true)
        } else {
            delegates.main.animateContentView(size: 100)
            self.desriptionLabel.isHidden = false
            delegates.statistics.contentViewVisibility(visibility: false)
        }
    }
    
    func locationDisabled() -> Bool{
        if location == ""{
            return true
        }
        return false
    }

}
