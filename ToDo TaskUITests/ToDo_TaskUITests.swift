//
//  ToDo_TaskUITests.swift
//  ToDo TaskUITests



import XCTest

final class ToDo_TaskUITests: XCTestCase {
    
    let app = XCUIApplication()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    func testLaunchInEnglish() {
        app.launchArguments = ["-AppleLanguage", "(en)"]
        app.launch()
        
        let header = app.staticTexts["Select the working profile"]
        XCTAssertTrue(header.exists, "The english header of 'Who is working today' is not found")
        
    }
    func testLaunchInSpanish() {
        app.launchArguments = ["-AppleLanguage", "(es)"]
        app.launch()
        
        let header = app.staticTexts["Selecciona el perfil de trabajo"]
        XCTAssertTrue(header.exists, "The Spanish header of 'Who is working today' is not found")
    }
}
//MARK 117 - 1

//func testUserFlow() throws {
//    let professorCard = app.buttons["proflieCard_Professor"]
//    XCTAssertTrue(professorCard.waitForExistence(timeout: 5), "The professor card is not found")
//    professorCard.tap()
//    
//    let addGroupButton = app.buttons["addGroupButton"]
//    XCTAssertTrue(addGroupButton.isEmpty, "The add group button is not found")
//    addGroupButton.tap()
//    
//    let groupNameField = app.textFields["newGroupNameField"]
//    XCTAssertTrue(addGroupButton.waitForExistence(timeout: 5))
//    
//}
//    let newGroupRow = app.buttons["groupRow_Testing Project"]
//    XCTAssertTrue(newGroupRow.waitForExistence(timeout: 5), "The Test Project group should be visible")
//    newGroupRow.tap()
//
//    let addTaskButton = app.buttons["addTaskButton"]
//    XCTAssertTrue(addTaskButton.isEmpty, "The add task button is not found")
//    addTaskButton.tap()
//
//    let taskTextField = app.textFields.firstMatch
//    taskTextField.tap()
//    taskTextField.typeText("Finish UI Test")
//
