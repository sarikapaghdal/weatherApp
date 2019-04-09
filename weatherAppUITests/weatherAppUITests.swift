//
//  weatherAppUITests.swift
//  weatherAppUITests
//
//  Created by Sarika on 02.04.19.
//  Copyright © 2019 Sarika. All rights reserved.
//

import XCTest

class weatherAppUITests: XCTestCase {

    let app = XCUIApplication()
    
    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    override func tearDown() {
    }
    
    func testNumberOfTableView() {
        let tableView = app.tables
        XCTAssertNotNil(tableView.count)
        XCTAssertEqual(tableView.count, 1, "There should be only 1 TableView View in our App")
    }
    
    func testNumberOfTableViewCell() {
        let tableView = app.tables
        XCTAssertNotEqual(tableView.cells.count, 0, "There should not be 0 Cell")
        XCTAssertNotNil(tableView.cells.count)
    }
    
    func testNumberOfSwitches() {
        let switchAvailable = app.switches
        XCTAssertNotEqual(switchAvailable.count, 0, "There should not be 0 Switch")
        XCTAssertNotNil(switchAvailable.count)
    }
    
    func testSwitchTap() {
         let switchAvailable = app.switches.element(boundBy: 0)
         XCTAssertNotNil(switchAvailable)
         switchAvailable.tap()
    }
    
    func testNumberOfImages() {
        let images = app.images
        XCTAssertNotNil(images.count)
        XCTAssertNotEqual(images.count, 1, "There should be more than 1 images in our App")
    }
    
    func testTableViewInteraction() {
        
        let viewCells = XCUIApplication().tables.cells
        
        if viewCells.count > 0 {
            let count: Int = (viewCells.count - 1)
            
            let promise = expectation(description: "Wait for view cells")
            
            for i in stride(from: 0, to: count , by: 1) {
                
                // Grab the ith cell and verify that it exists and tap it
                let tableViewCell = viewCells.element(boundBy: i)
                
                XCTAssertTrue(tableViewCell.exists, "The \(i) cell is in place on the table")
                // Does this actually tape on cell
                tableViewCell.tap()
                
                if i == (count - 1) {
                    promise.fulfill()
                }
            }
            waitForExpectations(timeout: 2, handler: nil)
            XCTAssertTrue(true, "Finished validating the table cells")
            
        } else {
            XCTAssert(false, "Was not able to find any table cells")
        }
    }
}
