//
//  RecipeTableViewController.swift
//  Recipes
//
//  Created by Marian on 11/22/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import UIKit

class RecipeTableViewController: BaseViewController{
    
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Class Properties
    var recipes: [Recipe] = []
    var presenter: RecipesPresenterProtocol?
    
    // MARK: -  func
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib.init(nibName: "RecipeCell", bundle: nil), forCellReuseIdentifier: "Cell")
        presenter = RecipesPresenter(view: self)
        presenter?.getRecipes()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }  
    
    private func logout(){
        
        UserDefaults.standard.set(nil, forKey: Constants.UserData.email)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let rootViewController  = appDelegate.window!.rootViewController
        
        if rootViewController is UINavigationController {
            
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let loginViewController = mainStoryboard.instantiateViewController(withIdentifier: "loginViewController") as! LoginViewController
            appDelegate.window?.rootViewController?.dismiss(animated: false, completion: nil)
            appDelegate.window?.rootViewController?.view.removeFromSuperview()
            appDelegate.window?.rootViewController = loginViewController
            appDelegate.window?.makeKeyAndVisible()
            
        }else{
            performSegue(withIdentifier: "unwindToLoginScreen", sender: self)
        }
    }
    
    // MARK: - IBAction
    
    @IBAction func didTouchLogOut(_ sender: Any) {
        
        let alertController = UIAlertController(title: nil, message: NSLocalizedString("LogoutMessage", comment: ""), preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let logoutAction = UIAlertAction(title: NSLocalizedString("LogOut", comment: ""), style: .default) { action -> Void in
            self.logout()
        }
        alertController.addAction(logoutAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func didTouchFavorite(_ sender: UIButton) {
        self.recipes[sender.tag].favorite = !self.recipes[sender.tag].favorite
        let indexPath = IndexPath(item: sender.tag, section: 0)
        if tableView.indexPathsForVisibleRows?.contains(indexPath) == true {
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
    }
}

// MARK: -  UITableViewDataSource implementation

extension RecipeTableViewController: UITableViewDataSource, UITableViewDelegate{
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return recipes.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RecipeTableViewCell
        setupRecipeDetailsCell(cell: cell, indexPath: indexPath)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let recipeDetailsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RecipeDetailsViewController") as! RecipeDetailsViewController
        recipeDetailsViewController.recipe = self.recipes[indexPath.row]
        self.navigationController?.pushViewController(recipeDetailsViewController, animated: true)
    }
    
    private func setupRecipeDetailsCell(cell: RecipeTableViewCell,indexPath: IndexPath){
        
        let recipe = recipes[indexPath.row]
        cell.descriptionLabel.text = recipe.description
        cell.nameLabel.text = recipe.name
        cell.headlineLabel.text = recipe.headline
        cell.rateView.delegate = self
        cell.rateView.tag = indexPath.row
        cell.favoriteButton.tag = indexPath.row
        cell.favoriteButton.addTarget(self, action: #selector(didTouchFavorite(_:)), for: .touchUpInside)
        cell.rateView.rating = recipe.rate
        if recipe.favorite{
            cell.favoriteButton.setImage(UIImage(named: "favorite"), for: .normal)
        }else{
            cell.favoriteButton.setImage(UIImage(named: "unfavorite"), for: .normal)
        }
    }
    
}
// MARK: - RecipesViewProtocol implementation

extension RecipeTableViewController: RecipesViewProtocol{
    
    func showRecipes(recipes: [Recipe]){
        self.recipes = recipes
        self.tableView.reloadData()
    }
    
}

// MARK: - RateViewDelegate implementation

extension RecipeTableViewController : RateViewDelegate {
    func rateView(rateView:RateView, ratingDidChange rating:Double) {
        print( "Rating: \(rating)")
        self.recipes[rateView.tag].rate = rating
    }
}
