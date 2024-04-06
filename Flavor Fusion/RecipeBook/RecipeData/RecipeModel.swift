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
    let servings: Int
    
    init(name: String, ingredients: [String], servings: Int) {
        self.id = UUID()
        self.name = name
        self.ingredients = ingredients
        self.servings = servings
    }
}
