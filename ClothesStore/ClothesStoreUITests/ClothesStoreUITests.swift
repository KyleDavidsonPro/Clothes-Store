//
//  ClothesStoreUITests.swift
//  ClothesStoreUITests
//
//  Created by Kyle Davidson on 05/12/2016.
//  Copyright © 2016 Kyle Davidson. All rights reserved.
//

import XCTest

class ClothesStoreUITests: XCTestCase {
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        if #available(iOS 9.0, *) {
            XCUIApplication().launch()
        } 

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddToBasket() {
        if #available(iOS 9.0, *) {
            let app = XCUIApplication()
            let storeTable = app.tables["SearchTable"]
            let storeCells = storeTable.cells
            
            XCUIDevice.shared().orientation = .portrait

            storeCells.staticTexts["Flip Flops, Red"].tap()
            app.buttons["Add To Cart"].tap()
            XCUIDevice.shared().orientation = .portrait
            
            let cartTable = app.tables["CartTable"]
            XCUIDevice.shared().orientation = .portrait
            XCUIApplication().tabBars.buttons["Cart"].tap()
            let cartEntry = XCUIApplication().tables["CartTable"].cells.staticTexts["Flip Flops, Red"]
            
            //Verify the item has been added to shopping cart
            XCTAssertNotNil(cartEntry)
            
            cartEntry.swipeLeft()
            cartTable.buttons["Delete"].tap()
            
            let existsPredicate = NSPredicate(format: "isHittable == false")
            self.expectation(for: existsPredicate,
                                 evaluatedWith: cartEntry, handler: nil)
            self.waitForExpectations(timeout: 5.0) { (error) -> Void in
                if error != nil {
                    fatalError("Failed to wait for \(cartEntry) after 3 seconds.")
                }
            }
        }
    }
}
