//
//  EmployeeViewModel.swift
//  MVVM-Practice
//
//  Created by Yahya BOURABA on 09/03/2021.
//

import Foundation

class EmployeeViewModel {
    let apiService: APIServiceProtocol
    private var employees: [Employee] = [Employee]()
    private var cellViewModels: [EmployeeCellViewModel] = [EmployeeCellViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    var alertMessage: String? {
        didSet {
            self.showAlertMessageClosure?()
        }
    }
    var numberOfCells: Int {
        return cellViewModels.count
    }
    var isAllowSegue: Bool = false
    var selectedEmployee: Employee?
    var reloadTableViewClosure: (() -> Void)?
    var showAlertMessageClosure: (() -> Void)?
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    func initFetchData() {
        apiService.fetchEmployeesData { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let employees):
                self.processFetchedEmployees(employees)
            case .failure(let error):
                self.alertMessage = error.rawValue
            }
        }
    }
    func getCellViewModel( at indexPath: IndexPath ) -> EmployeeCellViewModel {
            return cellViewModels[indexPath.row]
        }
    func createCellViewModel(employee: Employee) -> EmployeeCellViewModel {
        return EmployeeCellViewModel(employeName: employee.employeeName, employeAge: employee.employeeAge)
    }
    func processFetchedEmployees(_ employees: [Employee]) {
        self.employees = employees
        var emps = [EmployeeCellViewModel]()
        for employee in employees {
            emps.append(createCellViewModel(employee: employee))
        }
        self.cellViewModels = emps
    }
    func userPressed(at indexpath: IndexPath) {
        let employee = self.employees[indexpath.row]
        if let empSalary = Int(employee.employeeSalary) {
           if empSalary > 300000 {
                self.isAllowSegue = true
                self.selectedEmployee = employee
            } else {
                self.selectedEmployee = nil
                self.isAllowSegue = false
                self.alertMessage = Constants.alertManager
            }
        }
    }
}
