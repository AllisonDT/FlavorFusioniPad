//
//  RecipeModel.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 3/24/24.
//

import Foundation

struct Ingredient: Codable {
    let name: String
    let amount: Double
}

struct Recipe: Identifiable, Codable {
    let id: UUID
    let name: String
    let ingredients: [Ingredient]
    let servings: Int
    
    init(name: String, ingredients: [Ingredient], servings: Int) {
        self.id = UUID()
        self.name = name
        self.ingredients = ingredients
        self.servings = servings
    }
}
