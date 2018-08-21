//
//  RecipeDetailsViewController.swift
//  Recipes
//
//  Created by Marian on 11/24/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import UIKit

class RecipeDetailsViewController: BaseViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Class Properties
    
    /** This property is set by RecipeTableViewController at didSelectRowAt */
    var recipe: Recipe?
    
    // Now it's clearly explained what each section is supposed to display
    enum SectionType {
        case summary, ingredients
    }
    
    // Now it's easy to re-order or add new sections
    let sections: [SectionType] = [.summary, .ingredients]
    // MARK: -  func
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell().classForCoder, forCellReuseIdentifier: "Cell2")
        tableView.register(UINib.init(nibName: "RecipeCell", bundle: nil), forCellReuseIdentifier: "Cell1")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: -  IBAction
    
    @IBAction func didTouchFavorite(_ sender: UIButton) {
        self.recipe!.favorite = !self.recipe!.favorite
        let indexPath = IndexPath(item: 0, section: 0)
        if tableView.indexPathsForVisibleRows?.contains(indexPath) == true {
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}

// MARK: -  UITableViewDataSource implementation

extension RecipeDetailsViewController: UITableViewDataSource{
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        let sectionType = sections[section]
        switch sectionType {
        case .summary:
            return 1
        case .ingredients:
            return recipe?.ingredients?.count ?? 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionType = sections[section]
        switch sectionType {
        case .summary:
            return nil
        case .ingredients:
            return "Ingredients"
        }
        
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath) as! RecipeTableViewCell
            setupRecipeDetailsCell(cell: cell, indexPath: indexPath)
            return cell
            
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath)
            cell.textLabel?.text = recipe?.ingredients![indexPath.row]
            return cell
        }
    }
    
    private func setupRecipeDetailsCell(cell: RecipeTableViewCell,indexPath: IndexPath){
        
        cell.descriptionLabel.text = recipe?.description
        cell.nameLabel.text = recipe?.name
        cell.headlineLabel.text = recipe?.headline
        cell.rateView.delegate = self
        cell.rateView.tag = indexPath.row
        cell.favoriteButton.tag = indexPath.row
        cell.favoriteButton.addTarget(self, action: #selector(didTouchFavorite(_:)), for: .touchUpInside)
        cell.rateView.rating = (recipe?.rate)!
        cell.kcalLabel.text = recipe?.calories!
        
        if (recipe?.favorite)!{
            cell.favoriteButton.setImage(UIImage(named: "favorite"), for: .normal)
        }else{
            cell.favoriteButton.setImage(UIImage(named: "unfavorite"), for: .normal)
        }
    }
    
}
// MARK: - RateViewDelegate implementation

extension RecipeDetailsViewController : RateViewDelegate {
    func rateView(rateView:RateView, ratingDidChange rating:Double) {
        print( "Rating: \(rating)")
        recipe?.rate = rating
    }
}
