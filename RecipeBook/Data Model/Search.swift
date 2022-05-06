//
//  Search.swift
//  RecipeBook
//
//  Created by anita on 19.04.2022.
//

import Foundation

typealias SearchComplete = (Bool) -> Void

class Search {
    var instractions = [String]()
    
    enum State {
        case notSearchedYet
        case loading
        case noResults
        case results([Result])
    }
    private let apiKey = "ef82e20a213a464789d031801d926649"
    private(set) var state: State = .notSearchedYet
    private var dataTask: URLSessionDataTask?
    
    func performSearch(for text: String, completion: @escaping SearchComplete) {
        if !text.isEmpty {
            dataTask?.cancel()
            state = .loading
            
            let url = spoonURL(searchText: text)
            let session = URLSession.shared
            dataTask = session.dataTask(with: url)  { data, response, error in
                var newState = State.notSearchedYet
                var success = false
                if let error = error as NSError?, error.code == -999 {
                    return
                }
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data {
                  var recipeResults = self.parse(data: data)
                    if recipeResults.isEmpty {
                        newState = .noResults
                    } else {
                        recipeResults.sort(by: <)
                        newState = .results(recipeResults)
                    }
                    success = true
                }
        
                DispatchQueue.main.async {
                    self.state = newState
                    completion(success)
                }
            }
            dataTask?.resume()
            }
        }
    
    
    private func spoonURL(searchText: String) -> URL {
        let encodedText = searchText.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let urlString = String(format: "https://api.spoonacular.com/recipes/complexSearch?query=%@&instructionsRequired=true&addRecipeInformation=true&number=100&apiKey=\(apiKey)", encodedText)
        let url = URL(string: urlString)
        return url!
    }

    
    private func parse(data: Data) -> [Result] {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(ResultArray.self, from: data)
           
            return result.results
        } catch {
            print("JSON Error: \(error)")
            return []
        }
    }
   
   
}

