//
//  SearchBar.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 7/20/24.
//

import SwiftUI

/// A search bar view for filtering recipes.
///
/// `SearchBar` is a `UIViewRepresentable` that integrates a `UISearchBar` into SwiftUI.
/// It updates the search text as the user types.
struct SearchBar: UIViewRepresentable {
    @Binding var searchText: String

    /// Coordinator class to handle `UISearchBar` delegate methods.
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var searchText: String

        init(searchText: Binding<String>) {
            _searchText = searchText
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            self.searchText = searchText
        }

        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(searchText: $searchText)
    }

    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = "Search Recipes"
        searchBar.searchBarStyle = .minimal
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = searchText
    }
}

/// A view that displays a list of recipes with search and add functionality.
///
/// `RecipeList` shows a searchable list of recipes and a button to add new recipes.
/// It filters recipes based on the search text.
struct RecipeList: View {
    @ObservedObject var recipeStore = RecipeStore()
    @ObservedObject var spiceDataViewModel: SpiceDataViewModel

    @State private var searchText: String = ""
    @State private var isAddRecipeViewPresented = false

    /// Filters the recipes based on the search text.
    var filteredRecipes: [Recipe] {
        if searchText.isEmpty {
            return recipeStore.recipes
        } else {
            return recipeStore.recipes.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    SearchBar(searchText: $searchText)
                    Spacer()
                    Button(action: {
                        isAddRecipeViewPresented.toggle()
                    }) {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 24))
                            .padding()
                            .foregroundColor(.blue)
                    }
                }
                .padding([.leading, .trailing, .top])

                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(filteredRecipes) { recipe in
                            RecipeRow(recipe: recipe, recipeStore: recipeStore, spiceDataViewModel: spiceDataViewModel)
                                .padding(.horizontal)
                        }
                    }
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarTitle("Recipes", displayMode: .inline)
        }
        .sheet(isPresented: $isAddRecipeViewPresented) {
            AddRecipeView(isPresented: $isAddRecipeViewPresented, recipeStore: recipeStore)
        }
    }
}
