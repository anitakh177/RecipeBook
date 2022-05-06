//
//  RecipeResult.swift
//  RecipeBook
//
//  Created by anita on 14.04.2022.
//

import UIKit

struct ResultArray: Codable {
    var results = [Result]()
   
    
}
struct Result: Codable, CustomStringConvertible {

    var title: String = ""
    var image = ""
    var readyInMinutes: Int? = 0
    var servings: Int? = 0
    var cuisines = [String]()
    var dishTypes = [String]()
    var diets = [String]()
    var occasions = [String]()
    var analyzedInstructions = [AnalyzedInstruction]()
    
    var description: String {
        return "\nResults - Name: \(title), Summary: \(String(describing: readyInMinutes ?? nil)), \(String(describing: servings ?? nil)) "
    }
}
// MARK: - Steps

struct AnalyzedInstruction: Codable {
    var name: String? = ""
    var steps = [Step]()
    
}

struct Step: Codable {
    var number: Int = 0
    var step: String = ""
    var ingredients = [Ent]()
    //var length: Length?
}
struct Ent: Codable {
    var id: Int
    var name, localizedName, image: String
    var temperature: Length?
}


struct Length: Codable {
    var number: Int = 0
    var unit: Unit
}
enum Unit: String, Codable {
    case fahrenheit = "Fahrenheit"
    case minutes = "minutes"
}


func < (lhs: Result, rhs: Result) -> Bool {
    return lhs.title.localizedStandardCompare(rhs.title) == .orderedAscending 
}
