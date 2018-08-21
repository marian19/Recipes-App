//
//  Recipe.swift
//  Recipes
//
//  Created by Marian on 11/22/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import Foundation

struct Recipe {
    let name: String
    let headline: String
    let description: String
    let ingredients: [String]?
    let calories: String?
    var rate: Double = 0
    var favorite: Bool = false
    
    init?(json: [String: Any]) {
        
        guard let name = json[Constants.RecipeData.name] as? String,
            let headline = json[Constants.RecipeData.headline] as? String,
            let description = json[Constants.RecipeData.description] as? String
            else {
                return nil
        }
        self.name = name
        self.description = description
        self.headline = headline
        self.ingredients = json[Constants.RecipeData.ingredients] as? [String]
        self.calories = json[Constants.RecipeData.calories] as? String
    }
    
}
