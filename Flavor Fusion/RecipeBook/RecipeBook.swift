//
//  RecipeBook.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 3/24/24.
//

import SwiftUI

struct RecipeBook: View {
    @State private var isAddRecipeViewPresented: Bool = false
    @ObservedObject var recipeStore = RecipeStore()
    
    var body: some View {
        NavigationStack {
            VStack {
                // Title of the Recipe Book
                Text("Recipe Book")
                    .font(.title)
                    .padding()
                
                // Favorite Recipes Section
//                VStack {
//                    HStack {
//                        // Displaying favorite recipe circles for three different recipes
//                        FavoriteRecipeCircle(spiceName: "Taco Seasoning")
//                        FavoriteRecipeCircle(spiceName: "Pizza")
//                        FavoriteRecipeCircle(spiceName: "Secret Spice")
//                    }
//                    .padding()
//                }
                
                // Displaying the list of recipes
                RecipeList()
                    .padding()
                
                // Button to add a new recipe
//                Button(action: {
//                    isAddRecipeViewPresented.toggle()
//                }) {
//                    Text("Add Recipe")
//                        .frame(width: 200, height: 60)
//                        .foregroundColor(.white)
//                        .background(Color.blue)
//                        .cornerRadius(8)
//                }
//                .padding()
//                .sheet(isPresented: $isAddRecipeViewPresented) {
//                    AddRecipeView(isPresented: $isAddRecipeViewPresented, recipeStore: recipeStore)
//                }
            }
        }
    }
}

// Preview Provider for the RecipeBook view
struct RecipeBook_Previews: PreviewProvider {
    static var previews: some View {
        RecipeBook()
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
