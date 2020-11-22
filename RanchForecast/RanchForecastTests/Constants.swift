//
//  Constants.swift
//  RanchForecastTests
//
//  Created by Waleed Alassaf on 22/11/2020.
//  Copyright © 2020 Big Nerd Ranch. All rights reserved.
//

import Foundation

enum Constants {
    
    static let urlString = "https://training.bignerdranch.com/classes/test-course"
    static let url = URL(string: urlString)!
    static let title = "Test Course"
    
    static let dateString = "2014-06-02"
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    static let date = dateFormatter.date(from: dateString)!
    
    static let validCourseDict: [String: Any] = ["title": title,
                                                 "url": urlString,
                                                 "upcoming": [["start_date": dateString]] ]
    
    static let courseDictionary = ["courses": [validCourseDict]]
    
    static let okResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
    
    static let jsonData = try! JSONSerialization.data(withJSONObject: courseDictionary)
    
    static let sessionConfiguration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [FakeScheduleURLProtocol.self]
        return config
    }()
    
}
