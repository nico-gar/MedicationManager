//
//  MedicationListViewController.swift
//  MedicationManager
//
//  Created by Nicolas Garaycochea on 11/22/22.
//

import UIKit

class MedicationListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var moodSurveyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MedicationController.shared.fetchMedication()
        guard let survey = MoodSurveyController.shared.fetchTodaysSurvey()
        else { return }
        
        moodSurveyButton.setTitle(survey.mentalState, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    

    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        
    }
    
    
    @IBAction func surveyButtonTapped(_ sender: UIButton) {
        guard let moodSurveyViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "moodSurveyViewController")
        as? MoodSurveyViewController else { return }
        
        moodSurveyViewController.delegate = self
        
        navigationController?.present(moodSurveyViewController, animated: true, completion: nil)
        
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMedicationDetails",
           let indexPath = tableView.indexPathForSelectedRow,
           let destination = segue.destination as? MedicationDetailViewController {
            let medication = MedicationController.shared.sections[indexPath.section][indexPath.row]
            destination.medicaiton = medication
        }
            
    }

}

extension MedicationListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return MedicationController.shared.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MedicationController.shared.sections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "medicationCell", for: indexPath) as? MedicationTableViewCell
        else { return UITableViewCell() }
        
        let medication = MedicationController.shared.sections[indexPath.section][indexPath.row]
        
        cell.configure(with: medication)
        cell.delegate = self

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Not Taken"
        } else if section == 1 {
            return "Taken"
        } else {
            return nil
        }
    }
}

extension MedicationListViewController: UITableViewDelegate {}

extension MedicationListViewController: MedicationTableViewCellDelegate {
    func medicationWasTakenButtonTapped(medication: Medication, wasTaken: Bool) {
        MedicationController.shared.markMedicationTaken(medication: medication, wasTaken: wasTaken)
        tableView.reloadData()
    }
}

extension MedicationListViewController: MoodSurveyViewControllerDelegate {
    func moodButtonTapped(with emoji: String) {
        MoodSurveyController.shared.didTapMoodEmoji(emoji)
        moodSurveyButton.setTitle(emoji, for: .normal)
    }
}
