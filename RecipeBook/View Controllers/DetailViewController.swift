//
//  DetailViewController.swift
//  RecipeBook
//
//  Created by anita on 19.04.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    var mainStackView = UIStackView()
    var scrollView = UIScrollView()
    
    var recipeResult: Result!
    var downloadTask: URLSessionDownloadTask?
      var result = [Result]()

    override func viewDidLoad() {
        super.viewDidLoad()
        if recipeResult != nil {
            title = recipeResult.title
    
            setupScrollView()
            setupMainStackView()
        }
   
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
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
        mainStackView.distribution = .equalSpacing
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.backgroundColor = .blue
        
        scrollView.addSubview(mainStackView)
        let contentLayoutGuide = scrollView.contentLayoutGuide
        
        NSLayoutConstraint.activate([mainStackView.widthAnchor.constraint(equalTo: view.widthAnchor),
                                     mainStackView.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor),
                                     mainStackView.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor),
                                     mainStackView.topAnchor.constraint(equalTo: contentLayoutGuide.topAnchor),
                                    
                                     mainStackView.bottomAnchor.constraint(equalTo: contentLayoutGuide.bottomAnchor)
                                    ])
        configureImage()
        instractionLabel()
       
    }
    
    private lazy var instractionTitle: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.text = "Instarction"
        label.font = UIFont(name: "Thonburi-Bold", size: 20)
        
        return label
    }()
    
    private func createLabel(with text: String) -> UILabel {
      let label = UILabel()
      label.textAlignment = .left
      label.numberOfLines = 0
      label.backgroundColor = .red
      label.lineBreakMode = .byWordWrapping
      label.text = text
      label.sizeToFit()
        
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
        imgView.sizeToFit()
        
        mainStackView.addArrangedSubview(imgView)
        NSLayoutConstraint.activate([imgView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor),
                                     imgView.centerXAnchor.constraint(equalTo: mainStackView.centerXAnchor),
                                     
                                    
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
        finalString += "\($0.number). \($0.step)\n\n"
        print(finalString)
     }
     createLabel(with: finalString)
     
      }
  

    
    // MARK: - Actions
    
    @IBAction func close() {
        navigationController?.popViewController(animated: true)
    }

  
}
