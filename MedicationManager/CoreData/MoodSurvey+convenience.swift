//
//  MoodSurvey+convenience.swift
//  MedicationManager
//
//  Created by Nicolas Garaycochea on 11/26/22.
//

import CoreData

extension MoodSurvey{
    @discardableResult convenience init(mentalState: String, date: Date, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.mentalState = mentalState
        self.date = date
    }
}


