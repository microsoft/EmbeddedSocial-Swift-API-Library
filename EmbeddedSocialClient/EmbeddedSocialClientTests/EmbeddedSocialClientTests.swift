//
//  EmbeddedSocialClientTests.swift
//  EmbeddedSocialClientTests
//
//  Created by Sharad Agarwal on 7/20/17.
//  Copyright © 2017 Microsoft Embedded Social. All rights reserved.
//

import XCTest
@testable import EmbeddedSocialClient

class EmbeddedSocialClientTests: XCTestCase {
    
    let testTimeout = 10.0
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetBuildsCurrent() {
        let expectation = self.expectation(description: "testGetBuildsCurrent")
        
        // let appKey = "xx"
        // EmbeddedSocialClientAPI.customHeaders = ["Authorization" : "Anon AK=\(appKey)"]
        EmbeddedSocialClientAPI.basePath = "https://ppe.embeddedsocial.microsoft.com"
        BuildsAPI.buildsGetBuildsCurrent { (buildsCurrentResponse: BuildsCurrentResponse?, error: Error?) in
            if let error = error {
                XCTFail("error getting builds info : \(error.localizedDescription)")
                return
            }

            guard let buildsCurrentResponse = buildsCurrentResponse else {
                XCTFail("did not get builds current response")
                return
            }
            
            XCTAssert(buildsCurrentResponse.commitHash != nil)
            XCTAssert(!buildsCurrentResponse.commitHash!.isEmpty)
            print("commit hash is \(buildsCurrentResponse.commitHash!)")
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: testTimeout) { error in
            if let error = error {
                XCTFail("waitForExpectations errored: \(error)")
            }
        }
    }
}
