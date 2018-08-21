//
//  RecipeDataSource.swift
//  Recipes
//
//  Created by Marian on 11/22/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import Foundation

struct RecipeDataSource {
    
    func getRecipes( completion: @escaping(_ response: [Recipe]) -> Void) {
        
        do {
            if let file = Bundle.main.url(forResource: "recipes", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                var recipes = [Recipe]()
                if let recipesJson = json as? [Any] {
                    for recipe in recipesJson{
                        recipes.append(Recipe(json: recipe as! [String : Any])!)
                    }
                    completion(recipes)
                } else {
                    print("JSON is invalid")
                }
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
