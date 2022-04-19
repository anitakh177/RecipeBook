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
    var readyInMinutes: Int? = 0
    var servings: Int? = 0
    
    var description: String {
        return "\nResults - Name: \(title), Summary: \(String(describing: readyInMinutes ?? nil)), \(String(describing: servings ?? nil)) "
    }
}
   /* // MARK: - Steps

class Step: Codable {
    var number: Int = 0
    var step: String = ""
    var ingredients, equipment: [Ent]
    var length: Length?
}
class Ent: Codable {
    var id: Int
    var name, localizedName, image: String
    var temperature: Length?
}


class Length: Codable {
    var number: Int = 0
    var unit: Unit
}
enum Unit: String, Codable {
    case fahrenheit = "Fahrenheit"
    case minutes = "minutes"
}
*/

func < (lhs: Result, rhs: Result) -> Bool {
    return lhs.title.localizedStandardCompare(rhs.title) == .orderedAscending 
}
