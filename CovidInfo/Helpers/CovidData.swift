//
//  CovidData.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 18.05.2022.
//

import Foundation

func dictionaryToTuple(dictionary: [String:Double]) -> [(String, Double)]{
    var tuple = [(String, Double)]()
    
    for (key,value) in dictionary {
        tuple.append((key,value))
    }
    
    return tuple
}

func dictionaryToDoubleArray(dictionary: [String:Double]) -> [Double] {
    var doubleArray = [Double]()
    
    for (_,value) in dictionary {
        doubleArray.append(value)
    }
    
    return doubleArray
}
