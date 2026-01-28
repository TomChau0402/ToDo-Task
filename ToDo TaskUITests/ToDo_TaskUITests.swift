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
    
    //MARK 117 - 1
    
    func testUserFlow() throws {
        let professorCard = app.buttons["proflieCard_Professor"]
        XCTAssertTrue(professorCard.waitForExistence(timeout: 5), "The professor card is not found")
        professorCard.tap()
        
        let addGroupButton = app.buttons["addGroupButton"]
        XCTAssertTrue(addGroupButton.exists, "The add group button is not found")
        addGroupButton.tap()
        
        let groupNameField = app.textFields["newGroupNameField"]
        XCTAssertTrue(addGroupButton.waitForExistence(timeout: 5))
        
        let newGroupRow = app.buttons["groupRow_Testing Project"]
        XCTAssertTrue(newGroupRow.waitForExistence(timeout: 5), "The Test Project group should be visible")
        newGroupRow.tap()
        
        let addTaskButton = app.buttons["addTaskButton"]
        XCTAssertTrue(addTaskButton.exists, "The add task button is not found")
        addTaskButton.tap()
        
        let taskTextField = app.textFields.firstMatch
        taskTextField.tap()
        taskTextField.typeText("Finish UI Test")
    }
    
    func testAddingTask() {
        let taskManager = TaskManager()
        taskManager.addTask(title: "Buy Groceries")
        XCTAssertEqual(taskManager.tasks.count, 1)
        XCTAssertEqual(taskManager.tasks.first?.title, "Buy Groceries")
        
    }
    func testMarkTaskCompleted() {
        let app = XCUIApplication()
        app.launch()
        
        let taskCell = app.tables.cells.element(boundBy: 0)
        taskCell.buttons["Complete"].tap()
        
        XCTAssertTrue(taskCell.buttons["Complete"].isSelected)
    }
    
    func testTaskHasPriority() {
        let task = Task(name: "Complete Homework")
        task.priority = .high
        XCTAssertEqual(task.priority, .high)
    }
}

func testAddTaskButton() throws {
    let firstProfile = app.button.matching(identifier: "profileCard_Professor").firstMatch
    XCTAssertTrue(firstProfile.waitForExistence(timeout: 5))
    firstProfile.tap()
    
    let firstGroup = app.buttons.matching(identifier: "groupCard_1").firstMatch
    XCTAssertTrue(firstGroup.waitForExistence(timeout: 5))
    firstGroup.tap()
}
func testModifyExistingTaskText() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["profileCard_Professor"].tap()
        app.buttons["groupRow_item"].tap()
        
       
        let taskPredicate = NSPredicate(format: "identifier BEGINSWITH %@", "taskTextField_")
        let firstTaskTextField = app.textFields.element(matching: taskPredicate).firstMatch
        
        XCTAssertTrue(firstTaskTextField.waitForExistence(timeout: 2),
                      "The task TextField should be found by its prefix identifier.")
        
        firstTaskTextField.tap()
        
        let currentValue = firstTaskTextField.value as? String ?? ""
        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: currentValue.count)
        firstTaskTextField.typeText(deleteString)
        
        firstTaskTextField.typeText("Buy Organic Apples")

        app.keyboards.buttons["Return"].tap()
        XCTAssertEqual(firstTaskTextField.value as? String, "Buy Organic Apples", "The task title should be updated.")
    }
