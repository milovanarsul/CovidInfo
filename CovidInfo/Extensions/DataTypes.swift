//
//  DataTypes.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 23.04.2022.
//

import Foundation

func getPercentage(array: [Double]) -> Int{
    let result = ((array[0] - array[1])/array[1])*100
    return result.toInt()!
}

extension Double {
    func toInt() -> Int? {
        let roundedValue = rounded(.toNearestOrEven)
        return Int(exactly: roundedValue)
    }
}
