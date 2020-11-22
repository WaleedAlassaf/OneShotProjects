//
//  ScheduleFetcher.swift
//  RanchForecastTests
//
//  Created by Waleed Alassaf on 22/11/2020.
//  Copyright © 2020 Big Nerd Ranch. All rights reserved.
//

import XCTest
@testable import RanchForecast


var fetcher: ScheduleFetcher!

class ScheduleFetcherTests: XCTestCase {
    override func setUp() {
        super.setUp()
        fetcher = ScheduleFetcher(configuration: Constants.sessionConfiguration)
    }
    override func tearDown() {
        fetcher = nil 
        super.tearDown()
    }
    
    func testCreateCourseFromValidDictionary() {
        let course: Course! = fetcher.parse(courseDictionary: Constants.validCourseDict)
        
        XCTAssertNotNil(course)
        XCTAssertEqual(course.title, Constants.title)
        XCTAssertEqual(course.url, Constants.url)
        XCTAssertEqual(course.nextStartDate, Constants.date)
    }
    
    func testResultFromValidHTTPResponseAndValidData() {
        let result = fetcher.digest(data: Constants.jsonData, response: Constants.okResponse, error: nil)
        
        switch result {
            case .success(let courses):
                XCTAssert(courses.count == 1)
                let theCourse = courses[0]
                XCTAssertEqual(theCourse.title, Constants.title)
                XCTAssertEqual(theCourse.url, Constants.url)
                XCTAssertEqual(theCourse.nextStartDate, Constants.date)
                
            default:
                XCTFail("Result Contains failure, but Success was expected")
                
        }
        
    }
    
    func testFetchCoursesCompletion() {
        
        let completionExpectation = expectation(description: "Execute completion closure")
        
        fetcher.fetchCourses { result in
            
            XCTAssertEqual(OperationQueue.current, OperationQueue.main,
                           "Completion handler should run on the main thread")
            
//            XCTFail("Is this thing on?")
            completionExpectation.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    
}
