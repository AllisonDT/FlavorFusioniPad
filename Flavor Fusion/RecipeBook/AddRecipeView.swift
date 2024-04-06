import SwiftUI

struct AddRecipeView: View {
    @Binding var isPresented: Bool
    @State private var recipeName: String = ""
    @State private var selectedServingsIndex: Int = 0
    let servings = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10] // You can customize this according to your needs
    @State private var isSelecting: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                // Text field for entering recipe name
                TextField("Enter Recipe Name", text: $recipeName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                // Picker for selecting number of servings
                Picker("Servings", selection: $selectedServingsIndex) {
                    ForEach(0..<servings.count) {
                        Text("\(self.servings[$0]) servings")
                    }
                }
                .pickerStyle(DefaultPickerStyle())
                .padding()
                
                ScrollView {
                    HStack {
                        LazyVGrid(columns: [GridItem(.flexible())]) {
                            ForEach(firstColumnSpices) { spice in
                                SpiceBlendSelections(spice: spice, isSelecting: isSelecting) { selected in
                                    if let index = spicesData.firstIndex(where: { $0.id == spice.id }) {
                                        spicesData[index].isSelected = selected
                                    }
                                }
                            }
                        }
                        .padding()
                        
                        LazyVGrid(columns: [GridItem(.flexible())]) {
                            ForEach(secondColumnSpices) { spice in
                                SpiceBlendSelections(spice: spice, isSelecting: isSelecting) { selected in
                                    if let index = spicesData.firstIndex(where: { $0.id == spice.id }) {
                                        spicesData[index].isSelected = selected
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            
            // Floating save button
            VStack {
                Spacer()
                Button(action: {
                    // add in save code
                }) {
                    Text("SAVE")
                        .frame(width: 200, height: 60)
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.green, lineWidth: 2)
                        )
                        .background(Color.green.opacity(0.5))
                        .cornerRadius(8)
                }
                .padding()
            }
        }
    }
}


struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView(isPresented: .constant(false))
    }
}
