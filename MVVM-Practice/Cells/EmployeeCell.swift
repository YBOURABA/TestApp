//
//  EmployeeCell.swift
//  MVVM-Practice
//
//  Created by Yahya BOURABA on 09/03/2021.
//

import UIKit

class EmployeeCell: UITableViewCell {
    @IBOutlet weak var employeeName: UILabel!
    @IBOutlet weak var employeeAge: UILabel!
    var employeeCellViewModel: EmployeeCellViewModel? {
        didSet {
            employeeName.text = employeeCellViewModel?.employeName
            employeeAge.text = employeeCellViewModel?.employeAge
        }
    }
}
