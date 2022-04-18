//
//  RecipeResultCell.swift
//  RecipeBook
//
//  Created by anita on 15.04.2022.
//

import UIKit

class RecipeResultCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var texTLabel: UILabel!
    @IBOutlet var servingsLabel: UILabel!
    @IBOutlet var recipeImageView: UIImageView!
    var downloadTask: URLSessionDownloadTask?

    override func awakeFromNib() {
        super.awakeFromNib()
        let selectedView = UIView(frame: CGRect.zero)
        selectedView.backgroundColor = UIColor(named: "orange")?.withAlphaComponent(0.5)
        selectedBackgroundView = selectedView
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(for result: Result) {
        nameLabel.text = result.title
        
        if result.readyInMinutes == nil || result.servings == nil {
            texTLabel.text = ""
            servingsLabel.text = ""
        } else {
            texTLabel.text = String(format: "%d", result.readyInMinutes!)
            servingsLabel.text = String(format: "%d", result.servings!)
            recipeImageView.image = UIImage(systemName: "square")
            if let imageFood = URL(string: result.image) {
                downloadTask = recipeImageView.loadImage(url: imageFood)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        downloadTask?.cancel()
        downloadTask = nil
    }

}
