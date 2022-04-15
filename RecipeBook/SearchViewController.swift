//
//  ViewController.swift
//  RecipeBook
//
//  Created by anita on 14.04.2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    let apiKey = "ef82e20a213a464789d031801d926649"
    var recipeResults = [RecipeResult]()
    var hasSearched = false
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    struct TableView {
        struct CellIdentifiers {
            static let recipeResultCell = "RecipeResultCell"
            static let nothingFoundCell = "NothingFoundCell"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 56, left: 0, bottom: 0, right: 0)
        
        var cellNib = UINib(nibName: TableView.CellIdentifiers.recipeResultCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.recipeResultCell)
        cellNib = UINib(nibName: TableView.CellIdentifiers.nothingFoundCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.nothingFoundCell)
        
    }
    // MARK: - Network
    
    func spoonURL(searchText: String) -> URL {
        let encodedText = searchText.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let urlString = String(format: "https://api.spoonacular.com/food/search?query=%@&apiKey=\(apiKey)", encodedText)
        let url = URL(string: urlString)
        return url!
    }
    
    func performStoreRequest(with url: URL) -> String? {
        do {
            return try String(contentsOf: url, encoding: .utf8)
        } catch {
            print("Download Error: \(error.localizedDescription)")
            return nil
        }
    }
   //"https://api.spoonacular.com/recipes/complexSearch?query=%@&type&apiKey=\(apiKey)"
}
// MARK: - Search Bar Delegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if !searchBar.text!.isEmpty {
            searchBar.resignFirstResponder()
            hasSearched = true
            recipeResults = []
            let url = spoonURL(searchText: searchBar.text!)
            print("URL: '\(url)'")
            
            if let jsonString = performStoreRequest(with: url) {
              print("Received JSON string '\(jsonString)'")
            }
        
            tableView.reloadData()
        }
    }
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}
// MARK: - Table View Delegate and Data Source

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !hasSearched {
          return 0
        } else if recipeResults.count == 0 {
          return 1
        } else {
          return recipeResults.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        if recipeResults.count == 0 {
            return tableView.dequeueReusableCell(withIdentifier: TableView.CellIdentifiers.nothingFoundCell, for: indexPath)
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableView.CellIdentifiers.recipeResultCell, for: indexPath) as! RecipeResultCell
            let recipeResult = recipeResults[indexPath.row]
            cell.nameLabel.text = recipeResult.name
            cell.texTLabel.text = recipeResult.text
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if recipeResults.count == 0 {
            return nil
        } else {
            return indexPath
        }
    }
}


    
