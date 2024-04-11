//
//  RecipeBook.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 3/24/24.
//

import SwiftUI

// This struct represents the main view of the Recipe Book.
struct RecipeBook: View {
    
    var body: some View {
        VStack {
            // Title of the Recipe Book
            Text("Recipe Book")
                .font(.title)
                .padding()
            
            // Favorite Recipes Section
            VStack {
                HStack {
                    // Displaying favorite recipe circles for three different recipes
                    FavoriteRecipeCircle(spiceName: "Taco Seasoning")
                    FavoriteRecipeCircle(spiceName: "Pizza")
                    FavoriteRecipeCircle(spiceName: "Secret Spice")
                }
                .padding()
            }
            
            // Displaying the list of recipes
            RecipeList()
                .padding()
        }
    }
}

// This struct represents the search bar used for searching recipes.
struct SearchBar: View {
    @Binding var searchText: String
    
    var body: some View {
        // Text field for entering search text
        TextField("Search", text: $searchText)
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
    }
}

// Preview Provider for the RecipeBook view
struct RecipeBook_Previews: PreviewProvider {
    static var previews: some View {
        RecipeBook()
    }
}
