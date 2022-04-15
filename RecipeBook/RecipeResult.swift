//
//  RecipeResult.swift
//  RecipeBook
//
//  Created by anita on 14.04.2022.
//

import UIKit

class RecipeResult {
    var name = ""
    var text = ""
}

class ResultArray: Codable {
    var searchResults = [SearchResult]()
}

class SearchResult: Codable {
    var results = [Result]()
}

class Result: Codable {
    var name: String? = ""
    //var image: String?
    var content: String? = ""
}
