//
//  CountryTravel+CoreDataProperties.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 01.06.2022.
//
//

import Foundation
import UIKit
import CoreData

extension CountryTravel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CountryTravel> {
        return NSFetchRequest<CountryTravel>(entityName: "CountryTravel")
    }

    @NSManaged public var icon: String?
    @NSManaged public var title: String?
    @NSManaged public var subtitle: [String : UIColor]?
    @NSManaged public var text: String?
    @NSManaged public var height: Float

}

extension CountryTravel : Identifiable {

}
