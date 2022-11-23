//
//  MedicationTableViewCell.swift
//  MedicationManager
//
//  Created by Nicolas Garaycochea on 11/22/22.
//

import UIKit

class MedicationTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var wasTakenButton: UIButton!
    

    @IBAction func wasTakenButtonTapped(_ sender: UIButton) {
        print("Was taken button tapped")
    }
}
