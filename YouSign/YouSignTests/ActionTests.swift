//
//  ActionTests.swift
//  YouSign
//
//  Created by Mahmoud Ben Messaoud on 29/05/2017.
//  Copyright © 2017 Mahmoud Ben Messaoud. All rights reserved.
//

import XCTest
@testable import YouSign

class ActionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_encryptedPassword_Should_return_6bc498d4dc47ec2177ff42151139da01c1660ddf_When_passwordIs_test123() {
        //arrange
        let mockedCredential = MockedCredential()
        mockedCredential.mockedPassword = "test123"
        let env = Environement(credential: mockedCredential)
        let action = Action(env)
        //Acte
        let result = action.encryptedPassword
        //assert
        XCTAssertEqual("6bc498d4dc47ec2177ff42151139da01c1660ddf", result)
    }
}
