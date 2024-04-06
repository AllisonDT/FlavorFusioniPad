//
//  RecipeBook.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 3/24/24.
//

import SwiftUI

struct RecipeBook: View {
    
    var body: some View {
        VStack {
            Text("Recipe Book")
                .font(.title)
                .padding()
            
            // Favorite Recipes Section
            VStack {
                HStack {
                    FavoriteRecipeCircle(spiceName: "Taco Seasoning")
                    FavoriteRecipeCircle(spiceName: "Pizza")
                    FavoriteRecipeCircle(spiceName: "Secret Spice")
                }
                .padding()
            }
            
            
            // Add RecipeList below the SearchBar
            RecipeList()
            
            .padding()
        }
    }
}

struct SearchBar: View {
    @Binding var searchText: String // Change to binding to update the search text
    
    var body: some View {
        TextField("Search", text: $searchText)
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
    }
}


struct RecipeBook_Previews: PreviewProvider {
    static var previews: some View {
        RecipeBook()
    }
}

