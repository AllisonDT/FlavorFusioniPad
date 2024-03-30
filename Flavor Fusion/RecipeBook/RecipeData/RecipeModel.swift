//
//  RecipeModel.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 3/24/24.
//

import Foundation

struct Recipe: Identifiable, Codable {
    let id: UUID
    let name: String
    let ingredients: [String]
    
    init(name: String, ingredients: [String]) {
        self.id = UUID()
        self.name = name
        self.ingredients = ingredients
    }
}
