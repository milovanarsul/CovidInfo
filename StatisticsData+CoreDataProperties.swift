//
//  StatisticsData+CoreDataProperties.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 24.04.2022.
//
//

import Foundation
import CoreData


extension StatisticsData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StatisticsData> {
        return NSFetchRequest<StatisticsData>(entityName: "StatisticsData")
    }

    @NSManaged public var allTimeConfirmedCasesValues: [Double]?
    @NSManaged public var allTimeCuredCasesValues: [Double]?
    @NSManaged public var allTimeMortalitiesValues: [Double]?
    @NSManaged public var casesForTheLastSevenDays: [Double]?
    @NSManaged public var casesForThePastMonth: [String : Double]?
    @NSManaged public var deathsForTheLastSevenDays: [Double]?
    @NSManaged public var deathsForThePastMonth: [String : Double]?
    @NSManaged public var incidence: [String : Double]?
    @NSManaged public var sevenDaysConfirmedCasesWithDates: [String : Double]?
    @NSManaged public var sevenDaysDeathsWithDates: [String : Double]?
    @NSManaged public var todaysNewCases: Int64
    @NSManaged public var todaysNewDeaths: Int64
    @NSManaged public var todaysRecovered: Int64
    @NSManaged public var totalNumberCured: Int64
    @NSManaged public var totalNumberDeceased: Int64
    @NSManaged public var totalNumberOfCases: Int64
}

extension StatisticsData : Identifiable {

}
