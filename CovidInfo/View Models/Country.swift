//
//  CountryCell.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 10.05.2022.
//

import Foundation

class Country {
    var image: String?
    var name: String?
    
    init(image: String, name: String){
        self.image = image
        self.name = name
    }
}

func countryModelData() -> [String : [Country]]{
    var data = [String: [Country]]()
    
    var countryData = [Country]()
    for(key, value) in roISOCountries{
        countryData.append(Country(image: key, name: value))
    }
    
    data["Alege o tara"] = countryData.sorted {$0.name! < $1.name!}
    return data
}

func simpleCountryData() -> [Country]{
    var countryData = [Country]()
    for(key, value) in roISOCountries{
        countryData.append(Country(image: key, name: value))
    }
    
    return countryData.sorted {$0.name! < $1.name!}
}
