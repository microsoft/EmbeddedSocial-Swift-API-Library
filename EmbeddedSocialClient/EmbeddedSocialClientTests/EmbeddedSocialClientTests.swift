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
    let testTimeout = 100.0
    
    // which server to talk to
    let serverURL = "https://dev-sharad.embeddedsocial.microsoft.com"
    
    // which authorization to use for API calls that require authentication
    let authorization = "XXX"
    
    // which images to use
    let myImageURL = URL(string: "https://i2.wp.com/sharadagarwaldotnet.files.wordpress.com/2016/02/sharad_suit_square2.jpg")

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
        EmbeddedSocialClientAPI.basePath = serverURL

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
        EmbeddedSocialClientAPI.basePath = serverURL
        
        // create a topic request
        let postTopicRequest = PostTopicRequest()
        postTopicRequest.title = "my new topic title"
        postTopicRequest.text = "my new topic text"
        postTopicRequest.blobType = PostTopicRequest.BlobType.unknown
        postTopicRequest.publisherType = PostTopicRequest.PublisherType.user
        
        // issue the API call
        TopicsAPI.topicsPostTopic(request: postTopicRequest, authorization: authorization) { (postTopicResponse: PostTopicResponse?, error: Error?) in
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
    
    // Test the PostImage API call using a resource file
    func testPostImageFromFile() {
        let expectation = self.expectation(description: "testPostImageFromFile")
        
        // setup the client interface
        EmbeddedSocialClientAPI.basePath = serverURL
        
        // load an image into memory
        let myImageFile = #imageLiteral(resourceName: "sharad")
        let imageData = UIImageJPEGRepresentation(myImageFile, 1.0)
        
        // issue the API call
        ImagesAPI.imagesPostImage(imageType: ImagesAPI.ImageType_imagesPostImage.contentBlob, authorization: authorization, image: imageData!) { (postImageResponse: PostImageResponse?, error: Error?) in
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
        
        self.waitForExpectations(timeout: self.testTimeout) { error in
            if let error = error {
                XCTFail("waitForExpectations errored: \(error)")
            }
        }
    }
    
    // Test the PostImage API call using a URL
    func testPostImageFromURL() {
        let expectation = self.expectation(description: "testPostImageFromURL")
        
        // setup the client interface
        EmbeddedSocialClientAPI.basePath = serverURL
        
        // load an image into memory
        let imageData : Data?
        do {
            imageData = try Data(contentsOf: myImageURL!)
            print("size of image is \(imageData!)")
        } catch {
            XCTFail("error loading image from URL: \(myImageURL!)")
            return
        }
        
        // issue the API call
        ImagesAPI.imagesPostImage(imageType: ImagesAPI.ImageType_imagesPostImage.contentBlob, authorization: authorization, image: imageData!) { (postImageResponse: PostImageResponse?, error: Error?) in
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
        
        self.waitForExpectations(timeout: self.testTimeout) { error in
            if let error = error {
                XCTFail("waitForExpectations errored: \(error)")
            }
        }
    }
}
