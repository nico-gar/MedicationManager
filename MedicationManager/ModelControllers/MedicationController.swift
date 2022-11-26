//
//  MedicationController.swift
//  MedicationManager
//
//  Created by Nicolas Garaycochea on 11/22/22.
//

import CoreData

class MedicationController {
    
    static let shared = MedicationController()
    
    private init() {}
    
    // private means only this controller can use it, lazy means it wont be initialized un we access the fetchRequest name
    private lazy var fetchRequest: NSFetchRequest<Medication> = {
        let request = NSFetchRequest<Medication>(entityName: "Medication")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    
    var sections: [[Medication]] { [notTakenMeds,takenMeds] }
    private var notTakenMeds: [Medication] = []
    private var takenMeds: [Medication] = []
    
    // CRUD
    
    func create(name: String, timeOfDay: Date) {
        let medication = Medication(name: name, timeOfDay: timeOfDay)
        notTakenMeds.append(medication)
        CoreDataStack.saveContext()
    }
    
    func fetchMedication() {
        let medications = (try? CoreDataStack.context.fetch(self.fetchRequest)) ?? []
        takenMeds = medications.filter { $0.wasTakenToday() }
        notTakenMeds = medications.filter { !$0.wasTakenToday()}
    }
    
    func updateMedication(medication: Medication, name: String, timeOfDay: Date) {
        medication.name = name
        medication.timeOfDay = timeOfDay
    }
    // need a review on this one with Aaron, this was so confusing!
    func markMedicationTaken(medication: Medication, wasTaken: Bool) {
        if wasTaken{
            TakenDate(date: Date(), medication: medication)
            if let index = notTakenMeds.firstIndex(of: medication){
                notTakenMeds.remove(at: index)
                takenMeds.append(medication)
            }
        }else{
            // mutable means to mutate, its used to make a change, we needed mutate because we called remove on takenDate
            let mutableTakenDates = medication.mutableSetValue(forKey: "takenDates")
            
            if let takenDate = (mutableTakenDates as? Set<TakenDate>)?.first(where: { takenDate in
                guard let date = takenDate.date
                else { return false }
                
                return Calendar.current.isDate(date, inSameDayAs: Date())
            }) {
                mutableTakenDates.remove(takenDate)
                if let index = takenMeds.firstIndex(of: medication){
                    takenMeds.remove(at: index)
                    notTakenMeds.append(medication)
                }
            }
        }
        CoreDataStack.saveContext()
    }
    
    func deleteMedication() {
        
    }
    
}
