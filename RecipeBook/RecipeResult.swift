//
//  RecipeResult.swift
//  RecipeBook
//
//  Created by anita on 14.04.2022.
//

import UIKit

class ResultArray: Codable {
    var results = [Result]()
    
}

// MARK: - Result
class Result: Codable, CustomStringConvertible {
    var description: String {
        return "\nResults - Name: \(title) "
    }
    
    //var id: Int
    var title: String = ""
    var image = ""

}
func < (lhs: Result, rhs: Result) -> Bool {
    return lhs.title.localizedStandardCompare(rhs.title) == .orderedAscending 
}
