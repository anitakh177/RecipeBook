//
//  ViewController.swift
//  RecipeBook
//
//  Created by anita on 14.04.2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    
    
    private let search = Search()
   
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    struct TableView {
        struct CellIdentifiers {
            static let recipeResultCell = "RecipeResultCell"
            static let nothingFoundCell = "NothingFoundCell"
            static let loadingCell = "LoadingCell"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 56, left: 0, bottom: 0, right: 0)
        
        var cellNib = UINib(nibName: TableView.CellIdentifiers.recipeResultCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.recipeResultCell)
        cellNib = UINib(nibName: TableView.CellIdentifiers.nothingFoundCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.nothingFoundCell)
        cellNib = UINib(nibName: TableView.CellIdentifiers.loadingCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.loadingCell)
        searchBar.searchTextField.backgroundColor = UIColor(red: 241/255, green: 245/255, blue: 248/255, alpha: 1)
        searchBar.searchTextField.leftView?.tintColor = UIColor(red: 255/255, green: 128/255, blue: 87/255, alpha: 1)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            if case .results(let list) = search.state {
            let detailViewController = segue.destination as! DetailViewController
            let indexPath = sender as! IndexPath
            let recipeResult = list[indexPath.row]
            detailViewController.recipeResult = recipeResult
            }
        }
            
    }
    // MARK: - Network
   
    
    func showNetworkError() {
        let alert = UIAlertController(title: "Whoops..." , message: "There was an error accessing the Recipe Book." + "Please try again.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

}
// MARK: - Search Bar Delegate

extension SearchViewController: UISearchBarDelegate {

    func performSearch() {
        search.performSearch(for: searchBar.text!) {
            success in
            if !success {
                self.showNetworkError()
            }
            self.tableView.reloadData()
        }
        tableView.reloadData()
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        performSearch()
        }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}
// MARK: - Table View Delegate and Data Source

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch search.state {
        case .notSearchedYet:
            return 0
        case .loading:
            return 1
        case .noResults:
            return 1
        case .results(let list):
            return list.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch search.state {
        case .notSearchedYet:
            fatalError("Should never get here")
            
        case .loading:
            let cell = tableView.dequeueReusableCell(withIdentifier: TableView.CellIdentifiers.loadingCell, for: indexPath)
            let spinner = cell.viewWithTag(100) as! UIActivityIndicatorView
            spinner.startAnimating()
            return cell
        case .noResults:
            return tableView.dequeueReusableCell(withIdentifier: TableView.CellIdentifiers.nothingFoundCell, for: indexPath)
        case .results(let list):
            let cell = tableView.dequeueReusableCell(withIdentifier: TableView.CellIdentifiers.recipeResultCell, for: indexPath) as! RecipeResultCell
                let recipeResult = list[indexPath.row]
                cell.configure(for: recipeResult)
                return cell
            }
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "ShowDetail", sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        switch search.state {
        case .notSearchedYet, .loading, .noResults:
            return nil
        case .results:
            return indexPath
        }
    }
}

