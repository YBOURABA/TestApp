//
//  APIService.swift
//  MVVM-Practice
//
//  Created by Yahya BOURABA on 09/03/2021.
//

import Foundation

protocol APIServiceProtocol {
  func fetchEmployeesData( completion : @escaping (Result<[Employee], APIError>) -> Void )
}
enum APIError: String, Error {
    case noNetwork = "No Network"
    case serverOverload = "Server is overloaded"
    case permissionDenied = "You don't have permission"
}

class APIService: APIServiceProtocol {
    private let baseURL = URL(string: Constants.urlAPI)
    func fetchEmployeesData(completion: @escaping (Result<[Employee], APIError>) -> Void) {
        URLSession.shared.dataTask(with: baseURL!) { (data, _ urlResponse, _ error ) in
            if let data = data {
                let jsonDecoder = JSONDecoder()
                let employeData = try? jsonDecoder.decode(Employees.self, from: data)
                if let employeData = employeData {
                    completion(.success(employeData.data))
                }
            }
        }.resume()
    }
}
