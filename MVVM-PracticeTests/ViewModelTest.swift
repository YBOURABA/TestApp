//
//  ViewModelTest.swift
//  MVVM-PracticeTests
//
//  Created by Yahya BOURABA on 15/03/2021.
//

import XCTest
@testable import MVVM_Practice

class ViewModelTest: XCTestCase {
    var mockAPIService: MockAPIService!
    var sut: EmployeeViewModel!

    override func setUp() {
        super.setUp()
        mockAPIService = MockAPIService()
        sut = EmployeeViewModel(apiService: mockAPIService)
    }
    override func tearDown() {
        mockAPIService = nil
        sut = nil
        super.tearDown()
    }
    func testFetchEmployees() {
        sut.initFetchData()
        XCTAssertTrue(mockAPIService!.isFetched)
    }
    func testFetchFailure() {
        let error = APIError.permissionDenied
        sut.initFetchData()
        mockAPIService.fetchFail(error: error)
        XCTAssertEqual(sut.alertMessage, error.rawValue)
    }
    func testAllowSegue() {
        let indexPath = IndexPath(row: 0, section: 0)
        self.getDataFromAPI()
        sut.userPressed(at: indexPath)
        XCTAssertTrue(sut.isAllowSegue)
        XCTAssertNotNil(sut.selectedEmployee)
    }
    func testNotManager() {
        let indexPath = IndexPath(row: 1, section: 0)
        self.getDataFromAPI()
        sut.userPressed(at: indexPath)
        XCTAssertFalse(sut.isAllowSegue)
        XCTAssertNil(sut.selectedEmployee)
    }
    func testGetCell() {
        let indexPath = IndexPath(row: 0, section: 0)
        self.getDataFromAPI()
        let vmCell = sut.getCellViewModel(at: indexPath)
        let employee = mockAPIService.completeEmpolyees[indexPath.row]
        XCTAssertEqual(vmCell.employeName, employee.employeeName)
    }
    func testCountCells() {
        self.getDataFromAPI()
        XCTAssertEqual(sut.numberOfCells, 2)
    }
}

extension ViewModelTest {
    func getDataFromAPI() {
        sut.initFetchData()
        mockAPIService.fetchSuccess()
    }
}
