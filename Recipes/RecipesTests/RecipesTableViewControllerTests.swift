//
//  RecipesTests.swift
//  RecipesTests
//
//  Created by Marian on 11/25/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import XCTest
@testable import Recipes

class RecipesTableViewControllerTests: XCTestCase {
    
    var viewController: RecipeTableViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        viewController = storyboard.instantiateViewController(withIdentifier: "RecipeTableViewController") as! RecipeTableViewController
        UIApplication.shared.keyWindow!.rootViewController = viewController
    }
    
    override func tearDown() {
        viewController = nil
        super.tearDown()
    }
    
    func testIBOutlest() {
        XCTAssertNotNil((viewController.tableView), "tableview not connected in storyboard")
    }
    
    func testProperties() {
        XCTAssertNotNil((viewController.presenter), "presenter not intialize")
    }
    
    func testJSONMapping() throws {
        
        guard let url = Bundle.main.url(forResource: "recipes", withExtension: "json") else {
            XCTFail("Missing file: recipes.json")
            return
        }
        let data = try Data(contentsOf: url)
        let json = try JSONSerialization.jsonObject(with: data, options: [])
        
        var recipes = [Recipe]()
        
        if let recipesJson = json as? [Any] {
            for recipe in recipesJson{
                recipes.append(Recipe(json: recipe as! [String : Any])!)
            }
            XCTAssertEqual(recipes[0].name, "Crispy Fish Goujons ")
            XCTAssertEqual(recipes[0].calories, "516 kcal")
        }
    }
    
}
