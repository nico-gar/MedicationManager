//
//  DateFormatter+Extras.swift
//  MedicationManager
//
//  Created by Nicolas Garaycochea on 11/23/22.
//

import Foundation

extension DateFormatter {
    static let medicaitonTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()
}
