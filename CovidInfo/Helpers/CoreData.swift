//
//  CoreData.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 23.04.2022.
//

import Foundation
import CoreData

func deleteAllCustomEntityObjects(context: NSManagedObjectContext){
    deleteAllEntityObjects(context: context, entityName: "Article")
    deleteAllEntityObjects(context: context, entityName: "MSPressBulettin")
    deleteAllEntityObjects(context: context, entityName: "CurrentData")
    deleteAllEntityObjects(context: context, entityName: "HistoricData")
}

func deleteAllEntityObjects(context: NSManagedObjectContext, entityName: String){
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
    
    do {
        try context.execute(deleteRequest)
    } catch let error as NSError {
        print(error)
    }
}
