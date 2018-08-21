//
//  RecipesPresenter.swift
//  Recipes
//
//  Created by Marian on 11/23/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import Foundation
class RecipesPresenter: BasePresenter, RecipesPresenterProtocol{
    
    weak var view: RecipesViewProtocol?
    
    required init(view: RecipesViewProtocol) {
        self.view = view
    }
    // MARK: - RecipesPresenterProtocol implementation
    
    func getRecipes(){
        
        RecipeDataSource().getRecipes {[weak self] recipes in
            self?.view?.showRecipes(recipes: recipes)
            
        }
        
    }
}
