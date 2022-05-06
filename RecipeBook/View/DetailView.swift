//
//  DetailView.swift
//  RecipeBook
//
//  Created by anita on 05.05.2022.
//

import UIKit

class DetailView: DetailViewController {

    var result1 = [Result]()
    
 
    
lazy var recipeImage: UIImageView = {
    let image = UIImageView()
    image.clipsToBounds = true
    image.contentMode = .scaleAspectFit
    image.translatesAutoresizingMaskIntoConstraints = false
    image.backgroundColor = .white
    return image
}()
    
        


}
