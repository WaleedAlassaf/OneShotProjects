//
//  FakeScheduleURLProtocol.swift
//  RanchForecastTests
//
//  Created by Waleed Alassaf on 22/11/2020.
//  Copyright © 2020 Big Nerd Ranch. All rights reserved.
//

import Foundation

class FakeScheduleURLProtocol: URLProtocol {
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        print("vending fake url response")
        
        client?.urlProtocol(self, didReceive: Constants.okResponse, cacheStoragePolicy: .notAllowed)
        
        client?.urlProtocol(self, didLoad: Constants.jsonData)
        
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {
        print("Done vending fake URL response")
    }
    
}
