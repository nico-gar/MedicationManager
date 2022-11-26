//
//  MedicationDetailViewController.swift
//  MedicationManager
//
//  Created by Nicolas Garaycochea on 11/22/22.
//

import UIKit

class MedicationDetailViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var medicaiton: Medication?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let medication = medicaiton,
           let timeOfDay = medication.timeOfDay{
            title = "Medication Details"
            nameTextField.text = medication.name
            datePicker.date = timeOfDay
        } else {
            title = "Add Medicaiton"
        }
        

    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let name = nameTextField.text,
              !name.isEmpty
        else { return }
        
        let timeOfDay = datePicker.date

        if let medication = medicaiton {
            MedicationController.shared.updateMedication(medication: medication, name: name, timeOfDay: timeOfDay)
        } else {
            MedicationController.shared.create(name: name, timeOfDay: timeOfDay)
        }

        navigationController?.popViewController(animated: true)
    }
}
