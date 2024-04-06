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
            Recipe(name: "Chili Powder", ingredients: ["Paprika", "Cayenne pepper", "Cumin", "Oregano", "Garlic powder", "Onion powder"], servings: 1),
            Recipe(name: "Taco Seasoning", ingredients: ["Chili powder", "Cumin", "Paprika", "Garlic powder", "Onion powder", "Red pepper flakes"], servings: 1),
            Recipe(name: "Cajun Seasoning", ingredients: ["Paprika", "Garlic powder", "Onion powder", "Cayenne pepper", "Thyme", "Oregano"], servings: 1),
            Recipe(name: "Italian Seasoning", ingredients: ["Dried basil", "Dried oregano", "Dried thyme", "Dried rosemary", "Dried marjoram", "Garlic powder"], servings: 1),
            Recipe(name: "Chinese Five Spice", ingredients: ["Star anise", "Cloves", "Cinnamon", "Sichuan peppercorns", "Fennel seeds"], servings: 1)
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
