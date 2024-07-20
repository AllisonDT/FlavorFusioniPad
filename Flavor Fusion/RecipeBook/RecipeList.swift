import SwiftUI

struct RecipeList: View {
    @ObservedObject var recipeStore = RecipeStore()
    
    @State private var searchText: String = ""
    @State private var isAddRecipeViewPresented = false
    
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
                    Spacer()
                    SearchBar(searchText: $searchText)
                    FiltersButton()
                    Button(action: {
                        isAddRecipeViewPresented.toggle()
                    }) {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 24))
                            .padding()
                    }
                }
                .padding([.leading, .trailing, .top])
                
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(filteredRecipes) { recipe in
                            RecipeRow(recipe: recipe, recipeStore: recipeStore)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .sheet(isPresented: $isAddRecipeViewPresented) {
            AddRecipeView(isPresented: $isAddRecipeViewPresented, recipeStore: recipeStore)
        }
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

struct RecipeRow: View {
    var recipe: Recipe
    var recipeStore: RecipeStore
    @State private var isMixPreviewPresented = false
    @State private var isDeleteAlertPresented = false

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Button(action: {
                    isMixPreviewPresented.toggle()
                }) {
                    Text(recipe.name)
                        .font(.headline)
                        .foregroundColor(.blue)
                }
                .sheet(isPresented: $isMixPreviewPresented) {
                    MixRecipePreview(recipe: recipe, isPresented: $isMixPreviewPresented)
                }
                
                Text("Servings: \(recipe.servings)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding()
            
            Spacer()
            
            Button(action: {
                isDeleteAlertPresented = true
            }) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
            .padding()
            .alert(isPresented: $isDeleteAlertPresented) {
                Alert(
                    title: Text("Delete Recipe"),
                    message: Text("Are you sure you want to delete this recipe?"),
                    primaryButton: .destructive(Text("Delete")) {
                        recipeStore.removeRecipe(recipe)
                    },
                    secondaryButton: .cancel()
                )
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white)
                .shadow(color: .gray, radius: 2, x: 0, y: 2)
        )
        .padding(.vertical, 4)
    }
}

struct RecipeList_Previews: PreviewProvider {
    static var previews: some View {
        RecipeList()
    }
}
