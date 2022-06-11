//
//  CovidData.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 18.05.2022.
//

import Foundation

func dictionaryToTuple(dictionary: [[String : Double]]) -> [(String, Double)]{
    var tuple = [(String, Double)]()
    
    for item in dictionary{
        for (key, value) in item{
            tuple.append((key, value))
        }
    }
    
    return tuple
}

func tupleArrayToArrayTuple(dict: [(String, Double)]) -> ([String], [Double]){
    var stringArray = [String]()
    var doubleArray = [Double]()
    
    for item in dict{
        stringArray.append(item.0)
        doubleArray.append(item.1)
    }
    
    return (stringArray, doubleArray)
}

func dictionaryToDoubleArray(dictionary: [[String : Double]]) -> [Double] {
    var doubleArray = [Double]()
    
    for item in dictionary{
        for (_, value) in item{
            doubleArray.append(value)
        }
    }
    
    return doubleArray
}

func countryToISO(country: String, dictionary: [String : String]) -> String?{
    for (key, value) in dictionary {
        if value == country{
            return key
        }
    }
    
    return nil
}

func monthToNumber(month: String) -> Int{
    for (key, value) in romanianMonths{
        if value == month{
            return key
        }
    }
    
    return 0
}

func dayToNumber(day: String) -> Int{
    for (key, value) in weekDays{
        if value == day {
            return key
        }
    }
    
    return 0
}

func stringFormatter(data: Double) -> String{
    let result = String(format: "%.0f", locale: Locale.current, data)
    return result
}
