//
//  CustomViewTransitionUITests.swift
//  CustomViewTransitionUITests
//
//  Created by Yoshikuni Kato on 2016/03/22.
//  Copyright © 2016年 Ohako Inc. All rights reserved.
//

import XCTest

class CustomViewTransitionUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        let staticText = app.staticTexts.element(boundBy: 0)

        app.buttons["Right"].tap()
        app.buttons["Back"].tap()
        
        XCTAssertTrue(staticText.label == "right")
        
        let leftButton = app.buttons["Left"]
        leftButton.tap()
        XCTAssertTrue(staticText.label == "left")
        
        
    }
    
}
