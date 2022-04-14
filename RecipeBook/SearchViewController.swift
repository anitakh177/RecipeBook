//
//  ViewController.swift
//  RecipeBook
//
//  Created by anita on 14.04.2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    var recipeResults = [RecipeResult]()
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 56, left: 0, bottom: 0, right: 0)
    }


}

// MARK: - Search Bar Delegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        recipeResults = []
        for i in 0...2 {
            let recipeResult = RecipeResult()
            recipeResult.name = String(format: "Fake Result %d for", i)
            recipeResult.text = searchBar.text!
            recipeResults.append(recipeResult)
        }
        tableView.reloadData()
    }
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}
// MARK: - Table View Delegate and Data Source

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "SearchResultCell"
        
        var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        }
        let recipeResult = recipeResults[indexPath.row]
        cell.textLabel!.text = recipeResult.name
        cell.detailTextLabel!.text = recipeResult.text
        return cell
    }
}
