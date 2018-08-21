//
//  RecipesContract.swift
//  Recipes
//
//  Created by Marian on 11/23/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import Foundation

protocol RecipesPresenterProtocol : class{
    func getRecipes()
}

protocol RecipesViewProtocol : class{
    func showRecipes(recipes: [Recipe])
}
