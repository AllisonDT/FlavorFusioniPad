//
//  RecipeBook.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 3/24/24.
//

import SwiftUI

struct RecipeBook: View {
    @State private var searchText: String = ""
    
    var filteredSpices: [Spice] {
        if searchText.isEmpty {
            return spicesData
        } else {
            return spicesData.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        VStack {
            Text("Recipe Book")
                .font(.title)
                .padding()
            
            // Favorite Recipes Section
            VStack {
                Text("Favorite Recipes")
                    .font(.headline)
                HStack {
                    FavoriteRecipeCircle(imageName: "recipe1")
                    FavoriteRecipeCircle(imageName: "recipe2")
                    FavoriteRecipeCircle(imageName: "recipe3")
                }
                .padding()
            }
            
            HStack {
                Spacer()
                SearchBar(searchText: $searchText)
                FiltersButton()
                AddButton()
            }
            .padding()
        }
    }
}


struct FavoriteRecipeCircle: View {
    var imageName: String
    
    var body: some View {
        Image(imageName)
            .resizable()
            .frame(width: 100, height: 100)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.black, lineWidth: 2))
            .shadow(radius: 5)
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

struct FiltersButton: View {
    var body: some View {
        Button(action: {
            // Action for Filters Button
        }) {
            Image(systemName: "line.horizontal.3.decrease.circle")
                .font(.system(size: 24))
                .padding()
        }
    }
}

struct AddButton: View {
    var body: some View {
        Button(action: {
            // Action for Add Button
        }) {
            Image(systemName: "plus.circle")
                .font(.system(size: 24))
                .padding()
        }
    }
}

#if DEBUG
struct RecipeBook_Previews: PreviewProvider {
    static var previews: some View {
        RecipeBook()
    }
}
#endif
