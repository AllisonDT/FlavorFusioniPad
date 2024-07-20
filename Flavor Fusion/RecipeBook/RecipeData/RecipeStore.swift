//
//  RecipeStore.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 3/24/24.
//

import Foundation

class RecipeStore: ObservableObject {
    @Published var recipes: [Recipe] = []

    init() {
        // Load recipes from storage if available, or initialize with sample data
        self.loadRecipes()
    }

    // Function to add a recipe to the store
    func addRecipe(_ recipe: Recipe) {
        recipes.append(recipe)
        saveRecipes()
    }

    // Function to remove a recipe from the store
    func removeRecipe(_ recipe: Recipe) {
        if let index = recipes.firstIndex(where: { $0.id == recipe.id }) {
            recipes.remove(at: index)
            saveRecipes()
        }
    }

    // Function to load recipes from storage (UserDefaults)
    private func loadRecipes() {
        if let data = UserDefaults.standard.data(forKey: "recipes") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Recipe].self, from: data) {
                recipes = decoded
                return
            }
        }
        // If no recipes found in UserDefaults, load sample data
        recipes += [
            Recipe(name: "Chili Powder", ingredients: [
                Ingredient(name: "Spice 1", amount: 1),
                Ingredient(name: "Spice 2", amount: 1),
                Ingredient(name: "Cumin", amount: 1),
                Ingredient(name: "Oregano", amount: 1),
                Ingredient(name: "Garlic powder", amount: 1),
                Ingredient(name: "Onion powder", amount: 1)
            ], servings: 1),
            Recipe(name: "Taco Seasoning", ingredients: [
                Ingredient(name: "Chili powder", amount: 1),
                Ingredient(name: "Cumin", amount: 1),
                Ingredient(name: "Paprika", amount: 1),
                Ingredient(name: "Garlic powder", amount: 1),
                Ingredient(name: "Onion powder", amount: 1),
                Ingredient(name: "Red pepper flakes", amount: 1)
            ], servings: 1),
            Recipe(name: "Cajun Seasoning", ingredients: [
                Ingredient(name: "Paprika", amount: 1),
                Ingredient(name: "Garlic powder", amount: 1),
                Ingredient(name: "Onion powder", amount: 1),
                Ingredient(name: "Cayenne pepper", amount: 1),
                Ingredient(name: "Thyme", amount: 1),
                Ingredient(name: "Oregano", amount: 1)
            ], servings: 1),
            Recipe(name: "Italian Seasoning", ingredients: [
                Ingredient(name: "Dried basil", amount: 1),
                Ingredient(name: "Dried oregano", amount: 1),
                Ingredient(name: "Dried thyme", amount: 1),
                Ingredient(name: "Dried rosemary", amount: 1),
                Ingredient(name: "Dried marjoram", amount: 1),
                Ingredient(name: "Garlic powder", amount: 1)
            ], servings: 1),
            Recipe(name: "Chinese Five Spice", ingredients: [
                Ingredient(name: "Star anise", amount: 1),
                Ingredient(name: "Cloves", amount: 1),
                Ingredient(name: "Cinnamon", amount: 1),
                Ingredient(name: "Sichuan peppercorns", amount: 1),
                Ingredient(name: "Fennel seeds", amount: 1)
            ], servings: 1)
        ]
    }

    // Function to save recipes to storage (UserDefaults)
    private func saveRecipes() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(recipes) {
            UserDefaults.standard.set(encoded, forKey: "recipes")
        }
    }
}
