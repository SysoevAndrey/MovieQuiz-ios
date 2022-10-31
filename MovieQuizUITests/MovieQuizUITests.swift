//
//  MovieQuizUITests.swift
//  MovieQuizUITests
//
//  Created by Andrey Sysoev on 27.10.2022.
//

import XCTest

final class MovieQuizUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        app = XCUIApplication()
        app.launch()
        
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        app.terminate()
        app = nil
    }
    
    func testYesButton() {
        let firstPoster = app.images["Poster"]
        
        app.buttons["Yes"].tap()
        
        let secondPoster = app.images["Poster"]
        let indexLabel = app.staticTexts["Index"]
        
        sleep(3)
        
        XCTAssertFalse(firstPoster == secondPoster)
        XCTAssertTrue(indexLabel.label == "2/10")
    }
    
    func testNoButton() {
        let firstPoster = app.images["Poster"]
        
        app.buttons["No"].tap()
        
        let secondPoster = app.images["Poster"]
        let indexLabel = app.staticTexts["Index"]
        
        sleep(3)
        
        XCTAssertFalse(firstPoster == secondPoster)
        XCTAssertTrue(indexLabel.label == "2/10")
    }
    
    func testGameFinish() {
        for _ in 1...10 {
            app.buttons["Yes"].tap()
            sleep(2)
        }

        let alert = app.alerts["Results"]

        XCTAssertTrue(alert.exists)
        XCTAssertTrue(alert.label == "Этот раунд окончен!")
        XCTAssertTrue(alert.buttons.firstMatch.label == "Cыграть ещё раз")
    }
    
    func testGameRestart() {
        for _ in 1...10 {
            app.buttons["Yes"].tap()
            sleep(2)
        }

        let alert = app.alerts["Results"]
        
        XCTAssertTrue(alert.exists)
        alert.buttons.firstMatch.tap()
        
        sleep(2)
        
        let indexLabel = app.staticTexts["Index"]
        
        XCTAssertFalse(alert.exists)
        XCTAssertTrue(indexLabel.label == "1/10")
    }
}
