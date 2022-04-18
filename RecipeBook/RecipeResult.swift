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

class Result: Codable, CustomStringConvertible {

    var title: String = ""
    var image = ""
    var readyInMinutes: Int = 0
    
    var description: String {
        return "\nResults - Name: \(title), Summary: \(readyInMinutes) "
    }
    
   
}
func < (lhs: Result, rhs: Result) -> Bool {
    return lhs.title.localizedStandardCompare(rhs.title) == .orderedAscending 
}
