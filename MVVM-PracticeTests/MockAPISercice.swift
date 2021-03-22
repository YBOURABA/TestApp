//
//  MockAPISercice.swift
//  MVVM-PracticeTests
//
//  Created by Yahya BOURABA on 15/03/2021.
//

import Foundation
@testable import MVVM_Practice

class MockAPIService: APIServiceProtocol {
    var isFetched = false
    var completeEmpolyees: [Employee] = [Employee(id: "1", employeeName: "Yahya", employeeSalary: "500000", employeeAge: "23", profileImage: ""),
                                         Employee(id: "2", employeeName: "Alex", employeeSalary: "200000", employeeAge: "45", profileImage: "")]
    var completeClosure: ((Bool, [Employee], APIError?) -> Void)!
    func fetchEmployeesData(completion: @escaping (Bool, [Employee], APIError?) -> Void) {
        isFetched = true
        completeClosure = completion
    }
    func fetchSuccess() {
            completeClosure( true, completeEmpolyees, nil )
        }

    func fetchFail(error: APIError?) {
            completeClosure( false, completeEmpolyees, error )
        }
}
