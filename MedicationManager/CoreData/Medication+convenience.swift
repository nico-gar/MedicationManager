//
//  Medication+convenience.swift
//  MedicationManager
//
//  Created by Nicolas Garaycochea on 11/23/22.
//

import CoreData

extension Medication {
    @discardableResult convenience init(name: String, timeOfDay: Date, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
        self.timeOfDay = timeOfDay
    }
    func wasTakenToday() -> Bool {
        if (takenDates as? Set<TakenDate>)?.contains(where: { takenDate in
            guard let date = takenDate.date
            else { return false }
            
            return Calendar.current.isDate(date, inSameDayAs: Date())
        }) == true {
            return true
        } else {
            return false
        }
    }
}
