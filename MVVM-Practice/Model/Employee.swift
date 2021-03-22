//
//  Employee.swift
//  MVVM-Practice
//
//  Created by Yahya BOURABA on 09/03/2021.
//

import Foundation

struct Employees: Decodable {
    let data: [Employee]
}

struct Employee: Decodable {
    let id: String
    let employeeName: String
    let employeeSalary: String
    let employeeAge: String
    let profileImage: String
    enum CodingKeys: String, CodingKey {
        case id
        case employeeName = "employee_name"
        case employeeSalary = "employee_salary"
        case employeeAge = "employee_age"
        case profileImage = "profile_image"
    }
}
