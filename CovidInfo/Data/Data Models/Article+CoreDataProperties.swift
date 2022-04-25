//
//  Article+CoreDataProperties.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 24.04.2022.
//
//

import Foundation
import CoreData

extension Article {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article")
    }

    @NSManaged public var articleDescription: String?
    @NSManaged public var author: String?
    @NSManaged public var backgroundImage: String?
    @NSManaged public var backgroundType: BackgroundType
    @NSManaged public var date: String?
    @NSManaged public var isTrusted: Bool
    @NSManaged public var link: String?
    @NSManaged public var title: String?
    @NSManaged public var viewMode: CardMode

}

extension Article : Identifiable {

}
