//
//  ViewController.swift
//  MVVM-Practice
//
//  Created by Yahya BOURABA on 09/03/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    lazy var viewModel: EmployeeViewModel = {
        return EmployeeViewModel()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        initViewModel()
    }
    func initViewModel() {
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        viewModel.showAlertMessageClosure = { [weak self] () in
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage {
                    let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
                        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                    self!.present(alert, animated: true, completion: nil)
                }
            }
        }
        viewModel.initFetchData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.cellidentifier, for: indexPath) else {
            fatalError(Constants.errorCell)
                }
        let cellViewModel = viewModel.getCellViewModel(at: indexPath)
        cell.employeeCellViewModel = cellViewModel
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.userPressed(at: indexPath)
        if viewModel.isAllowSegue {
            performSegue(withIdentifier: R.segue.mvvm_PracticeViewController.seeManager, sender: self)
        }
    }
}

extension ViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == R.segue.mvvm_PracticeViewController.seeManager.identifier {
            if let destVC = segue.destination as? ManagerViewController, let employee = viewModel.selectedEmployee {
                destVC.manager = employee.employeeName
            }
        }
    }
}
