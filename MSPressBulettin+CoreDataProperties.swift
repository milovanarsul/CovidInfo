//
//  MSPressBulettin+CoreDataProperties.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 24.04.2022.
//
//

import Foundation
import CoreData


extension MSPressBulettin {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MSPressBulettin> {
        return NSFetchRequest<MSPressBulettin>(entityName: "MSPressBulettin")
    }

    @NSManaged public var antigen: String?
    @NSManaged public var ati: String?
    @NSManaged public var numarPersoaneInternate: String?
    @NSManaged public var pacientiReinfectati: String?
    @NSManaged public var rtpcr: String?
    @NSManaged public var totalTesteAntigen: String?
    @NSManaged public var totalTestePCR: String?

}

extension MSPressBulettin : Identifiable {

}
