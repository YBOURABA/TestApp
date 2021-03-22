//
//  ManagerViewController.swift
//  MVVM-Practice
//
//  Created by Yahya BOURABA on 09/03/2021.
//

import UIKit

class ManagerViewController: UIViewController {

    @IBOutlet weak var managerLabel: UILabel!
    var manager: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let manager = manager {
        managerLabel.text = "\(manager) is a manager !"
        }
    }
}
