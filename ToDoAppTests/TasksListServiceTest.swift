//
//  TasksListServiceTest.swift
//  ToDoAppTests
//
//  Created by Никита Новицкий on 30.07.2025.
//

import XCTest
@testable import ToDoApp

final class TasksListServiceTest: XCTestCase {
    var sut: TasksListService!
    var list: TasksListModel!
    
    override func setUpWithError() throws {
        sut = TasksListService(coreDataManager: InMemoryCoreDataManager())
        list = TasksListModel(id: "1", title: "Some title", icon: "test.icon", tasks: [], createdAt: .now)
    }

    override func tearDownWithError() throws {
        sut = nil
        list = nil
        super.tearDown()
    }
    
    func testSaveTaskList_whenSaveAList_shouldBeOneOnDB() {
        sut.saveTaskList(list)
        print(sut.fetchTaskLists())
        XCTAssertEqual(sut.fetchTaskLists().count, 1)
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
