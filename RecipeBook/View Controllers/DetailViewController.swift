//
//  DetailViewController.swift
//  RecipeBook
//
//  Created by anita on 19.04.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    var recipeResult: Result!
    var downloadTask: URLSessionDownloadTask?
    
    @IBOutlet var imageDeatil: UIImageView!
    @IBOutlet var instractionName: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        if recipeResult != nil {
            updateUI()
        }
    }
    
    // MARK: - Helper Methods
    
    func updateUI() {
      
        if let imageURL = URL(string: recipeResult.image) {
            downloadTask = imageDeatil.loadImage(url: imageURL)
        }
    }
    
    // MARK: - Actions
    
    @IBAction func close() {
        navigationController?.popViewController(animated: true)
    }

  
}
