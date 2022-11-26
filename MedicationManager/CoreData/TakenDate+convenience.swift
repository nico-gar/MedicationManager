//
//  TakenDate+convenience.swift
//  MedicationManager
//
//  Created by Nicolas Garaycochea on 11/25/22.
//

import CoreData

extension TakenDate {
    @discardableResult convenience init(date: Date, medication: Medication, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.date = date
        self.medication = medication
    }
}
