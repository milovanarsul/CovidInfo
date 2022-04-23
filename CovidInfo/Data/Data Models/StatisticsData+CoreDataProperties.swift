//
//  StatisticsData+CoreDataProperties.swift
//  
//
//  Created by Milovan Arsul on 23.04.2022.
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
    @NSManaged public var casesForThePastMonth: [StringDoubleTuple]?
    @NSManaged public var deathsForTheLastSevenDays: [Double]?
    @NSManaged public var deathsForThePastMonth: [StringDoubleTuple]?
    @NSManaged public var incidence: [String : Double]?
    @NSManaged public var sevenDaysConfirmedCasesWithDates: [StringDoubleTuple]?
    @NSManaged public var sevenDaysDeathsWithDates: [StringDoubleTuple]?
    @NSManaged public var todaysNewCases: Int64
    @NSManaged public var todaysNewDeaths: Int64
    @NSManaged public var todaysRecovered: Int64
    @NSManaged public var totalNumberCured: Int64
    @NSManaged public var totalNumberDeceased: Int64
    @NSManaged public var totalNumberOfCases: Int64
}

enum Keys: String {
  case string = "String"
  case double = "Double"
}

public class StringDoubleTuple: NSObject, NSSecureCoding {

    static public var supportsSecureCoding: Bool {
        return true
    }
    
    var string: String
    var double: Double
    
    
    public func encode(with coder: NSCoder) {
        coder.encode(string as NSString, forKey: Keys.string.rawValue)
        coder.encode(double as NSNumber, forKey: Keys.double.rawValue)
    }
    
    public required init?(coder: NSCoder) {
        let string = coder.decodeObject(of: NSString.self, forKey: Keys.string.rawValue) as String? ?? ""
        let double = coder.decodeObject(of: NSNumber.self, forKey: Keys.string.rawValue)
    }
}
