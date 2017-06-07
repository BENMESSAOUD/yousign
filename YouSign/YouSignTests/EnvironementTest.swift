//
//  EnvironementTest.swift
//  YouSign
//
//  Created by Mahmoud Ben Messaoud on 22/05/2017.
//  Copyright © 2017 Mahmoud Ben Messaoud. All rights reserved.
//

import XCTest
@testable import YouSign

class EnvironementTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_credentials_Should_returnNotNilCredentials_When_allways() {
        //arrange
        let credential = MockedCredential()
        let environement = Environement(Target.production, credential: credential)
        //Acte
        let credentials = environement.credentials
        //assert
        XCTAssertNotNil(credentials)
    }

    func test_credentials_Should_returnDemoTarget_When_NoTagetParams() {
        //arrange
        let credential = MockedCredential()
        let environement = Environement(credential: credential)
        //Acte
        let target = environement.target
        //assert
        XCTAssertTrue(target == .demo)
    }

}

class MockedCredential: Credentials {
    var mockedLogin = "login"
    var mockedPassword = "password"
    var mockedApiKey = "api key"
    var login: String{
        return mockedLogin
    }

    var password: String {
        return mockedPassword
    }

    var apiKey : String {
        return mockedApiKey
    }
}
