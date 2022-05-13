//
//  DetailViewController.swift
//  RecipeBook
//
//  Created by anita on 19.04.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    var mainStackView = UIStackView()
    var imageStackView = UIStackView()
    var scrollView = UIScrollView()
    
    private let viewSpacer = UIView()
    
    var recipeResult: Result!
    var downloadTask: URLSessionDownloadTask?
    var result = [Result]()

    override func viewDidLoad() {
        super.viewDidLoad()
        if recipeResult != nil {
            title = "Recipe's Details"
            setupScrollView()
            setupMainStackView()
        }
    }

    func setupScrollView() {
        scrollView = UIScrollView(frame: view.bounds)
        //scrollView.backgroundColor = .green
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }
    
    func setupMainStackView() {
        mainStackView.axis = .vertical
        mainStackView.alignment = .fill
        mainStackView.distribution = .fillProportionally
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        //mainStackView.backgroundColor = .blue
        mainStackView.spacing = 20
        
        scrollView.addSubview(mainStackView)
        let contentLayoutGuide = scrollView.contentLayoutGuide
        
        NSLayoutConstraint.activate([mainStackView.widthAnchor.constraint(equalTo: view.widthAnchor),
                                     mainStackView.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor),
                                     mainStackView.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor),
                                     mainStackView.topAnchor.constraint(equalTo: contentLayoutGuide.topAnchor),
                                    
                                     mainStackView.bottomAnchor.constraint(equalTo: contentLayoutGuide.bottomAnchor)
                                    ])
       _ =  createRecipeTitle()
        configureImage()
        _ = createTitleLabel(with: "Ingridients")
        ingridientsLabel()
        _ = createTitleLabel(with: "Instractions")
        instractionLabel()
       
    }
    private func createRecipeTitle() -> UILabel {
        let recipeTitle = recipeResult.title
        let label = PaddingLabel()
        label.text = recipeTitle
        label.textAlignment = .center
        label.textColor = UIColor(named: "name")
        label.font = UIFont(name: "Georgia-Bold", size: 30)
        label.numberOfLines = 0
        label.paddingTop = 20
        
        mainStackView.addArrangedSubview(label)
        
        NSLayoutConstraint.activate([label.widthAnchor.constraint(equalTo: mainStackView.widthAnchor),
                                     label.centerXAnchor.constraint(equalTo: mainStackView.centerXAnchor)
                                    ])
        
        return label
    }
    
    private func createTitleLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.text = text
        label.font = UIFont(name: "Georgia-Bold", size: 20)
        label.textColor = UIColor(named: "name")
        mainStackView.addArrangedSubview(label)
        
        NSLayoutConstraint.activate([label.widthAnchor.constraint(equalTo: mainStackView.widthAnchor),
                                     label.centerXAnchor.constraint(equalTo: mainStackView.centerXAnchor)
                                     ])
        return label
    }
   
    private func createLabel(with text: String, postion: NSTextAlignment) -> UILabel {
      let label = PaddingLabel()
      label.textAlignment = postion
      label.numberOfLines = 0
      label.lineBreakMode = .byWordWrapping
      label.text = text
      label.font = UIFont(name: "Georgia", size: 17)
      label.textColor = UIColor(named: "textDetail")
      label.sizeToFit()
        
      label.paddingLeft = 15
      label.paddingRight = 15
      
      mainStackView.addArrangedSubview(label)
         NSLayoutConstraint.activate([label.widthAnchor.constraint(equalTo: mainStackView.widthAnchor),
                                     label.centerXAnchor.constraint(equalTo: mainStackView.centerXAnchor)
                                    ])
      return label
  }
    
    private func recipeImage() -> UIImageView  {
         
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.layer.cornerRadius = 15
        
        mainStackView.addArrangedSubview(imgView)
        NSLayoutConstraint.activate([imgView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor),
                                     imgView.centerXAnchor.constraint(equalTo: mainStackView.centerXAnchor)
                                  ])
        return imgView
    }
    
    private func configureImage() {
        if let imageFood = URL(string: recipeResult.image) {
            downloadTask = recipeImage().loadImage(url: imageFood)
    }
    
    }
    
  // MARK: - Helper Methods
 func instractionLabel() {
  
     var finalString = ""
     var _: () = recipeResult.analyzedInstructions[0].steps.forEach {
        finalString += "  \($0.number). \($0.step)\n\n"
            }
     _ = createLabel(with: finalString, postion: .natural)
     
      }
    
    
  func ingridientsLabel() {
    var finalString = ""
    var _: () = recipeResult.analyzedInstructions[0].steps[0].ingredients.forEach {
        finalString += "\($0.name ?? "")   "
       }
      _ = createLabel(with: finalString, postion: .center)
    
    }
  
    // MARK: - Actions
    
    @IBAction func close() {
        navigationController?.popViewController(animated: true)
    }
  
}
