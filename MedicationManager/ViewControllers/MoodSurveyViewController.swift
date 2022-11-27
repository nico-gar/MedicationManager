//
//  MoodSurveyViewController.swift
//  MedicationManager
//
//  Created by Nicolas Garaycochea on 11/26/22.
//

import UIKit

protocol MoodSurveyViewControllerDelegate: AnyObject {
    func moodButtonTapped(with emoji: String)
}

class MoodSurveyViewController: UIViewController {
    
    weak var delegate: MoodSurveyViewControllerDelegate?
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func emojiTapped(_ sender: UIButton) {
        guard let emoji = sender.titleLabel?.text
        else {return}
        
        delegate?.moodButtonTapped(with: emoji)
        dismiss(animated: true, completion: nil)

    }

}
