//
//  RecipesTests.swift
//  RecipesTests
//
//  Created by Marian on 11/21/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import XCTest
@testable import Recipes

class LoginViewControllerTests: XCTestCase {
    
    var viewController: LoginViewController!

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        viewController = storyboard.instantiateInitialViewController() as! LoginViewController
        UIApplication.shared.keyWindow!.rootViewController = viewController
    }
    
    override func tearDown() {
        viewController = nil
        super.tearDown()
    }
    
    func testIBOutlest() {
        XCTAssertNotNil((viewController.emailTextField ), "emailTextField not connected in storyboard")
        XCTAssertNotNil((viewController.passwordTextField), "passwordTextField not connected in storyboard")
        
    }
    
    func testProperties() {
        
        XCTAssertNotNil((viewController.presenter), "presenter not intialize")
        
    }
    
    func testSignIn() {
        viewController.viewDidLoad()
        let presenter = MockPresenter()
        viewController.presenter = presenter
        presenter.login(email: "a@a.com", password: "zxcvbnmk")
        XCTAssertTrue(presenter.succesLogin , "login should have been called")
        
    }

    
}

class MockPresenter: LoginPresenterProtocol {
    var succesLogin = false
    
    func login(email: String, password: String) {
        if email.isEmail && password.isValidPassword{
        succesLogin = true
        }
    }

    
}
