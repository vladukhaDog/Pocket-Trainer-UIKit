//
//  SavedExercise+CoreDataProperties.swift
//  
//
//  Created by vladukha on 23.10.2021.
//
//

import Foundation
import CoreData


extension SavedExercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedExercise> {
        return NSFetchRequest<SavedExercise>(entityName: "SavedExercise")
    }

    @NSManaged public var date: Date
    @NSManaged public var exerciseID: Int32
    @NSManaged public var id: UUID
    @NSManaged public var repsNumber: [Int]
    @NSManaged public var weights: [Int]

	
}
