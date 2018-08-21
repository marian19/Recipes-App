//
//  RecipeTableViewCell.swift
//  Recipes
//
//  Created by Marian on 11/23/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rateView:RateView!
    @IBOutlet weak var favoriteButton:UIButton!
    @IBOutlet weak var kcalLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.rateView.notSelectedImage = UIImage(named: "GoldStarEmpty")
        self.rateView.fullSelectedImage = UIImage(named: "GoldStarFilled")
        self.rateView.rating = 0
        self.rateView.editable = true
        self.rateView.maxRating = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
