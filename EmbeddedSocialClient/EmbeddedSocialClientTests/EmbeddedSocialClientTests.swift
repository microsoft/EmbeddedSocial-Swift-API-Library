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
    
    // how long to wait for async API calls to finish before giving up
    let testTimeout = 10.0
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    override func setUp() {
        super.setUp()
    }
    
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    override func tearDown() {
        super.tearDown()
    }
    
    // Test the GetBuildsCurrent API call
    func testGetBuildsCurrent() {
        let expectation = self.expectation(description: "testGetBuildsCurrent")
        
        // setup the client interface
        EmbeddedSocialClientAPI.basePath = "https://ppe.embeddedsocial.microsoft.com"

        // issue the call
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
    
    // Test the PostTopic API call
    func testPostTopic() {
        let expectation = self.expectation(description: "testPostTopic")
        
        // setup the client interface
        let appKey = "XX"
        let token = "XX"
        EmbeddedSocialClientAPI.basePath = "https://ppe.embeddedsocial.microsoft.com"
        EmbeddedSocialClientAPI.customHeaders = ["Authorization":"Google AK=\(appKey)|TK=\(token)"]
        
        // create a topic request
        let postTopicRequest = PostTopicRequest()
        postTopicRequest.title = "my new topic title"
        postTopicRequest.text = "my new topic text"
        postTopicRequest.blobType = PostTopicRequest.BlobType.unknown
        postTopicRequest.publisherType = PostTopicRequest.PublisherType.user
        
        // issue the API call
        TopicsAPI.topicsPostTopic(request: postTopicRequest) { (postTopicResponse: PostTopicResponse?, error: Error?) in
            if let error = error {
                XCTFail("error posting new topic : \(error.localizedDescription)")
                return
            }
            
            guard let postTopicResponse = postTopicResponse else {
                XCTFail("did not get post topic response")
                return
            }
            
            XCTAssert(postTopicResponse.topicHandle != nil)
            XCTAssert(!postTopicResponse.topicHandle!.isEmpty)
            print("new topic handle is \(postTopicResponse.topicHandle!)")
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: testTimeout) { error in
            if let error = error {
                XCTFail("waitForExpectations errored: \(error)")
            }
        }
    }
    
    // Test the PostImage API call
    func testPostImage() {
        let expectation = self.expectation(description: "testPostImage")
        
        // setup the client interface
        let appKey = "XX"
        let token = "XX"
        EmbeddedSocialClientAPI.basePath = "https://ppe.embeddedsocial.microsoft.com"
        EmbeddedSocialClientAPI.customHeaders = ["Authorization":"Google AK=\(appKey)|TK=\(token)"]
        
        // load an image into memory
        guard let imageData = UIImagePNGRepresentation(UIImage(named: "image_2000")!) else {
            XCTFail("not able to load image")
            return
        }
        
        // issue the API call
        ImagesAPI.imagesPostImage(imageType: ImagesAPI.ImageType_imagesPostImage.contentBlob, image: imageData) { (postImageResponse: PostImageResponse?, error: Error?) in
            if let error = error {
                XCTFail("error posting new image : \(error.localizedDescription)")
                return
            }
            
            guard let postImageResponse = postImageResponse else {
                XCTFail("did not get post image response")
                return
            }
            
            XCTAssert(postImageResponse.blobHandle != nil)
            XCTAssert(!postImageResponse.blobHandle!.isEmpty)
            print("new blob handle is \(postImageResponse.blobHandle!)")
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: testTimeout) { error in
            if let error = error {
                XCTFail("waitForExpectations errored: \(error)")
            }
        }
    }
}
