import SwiftUI

struct BlendingNewExistingView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isNewBlendPopupVisible = false
    @State private var selectedOption = 0 // 0 for New, 1 for Existing
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                // Segmented control for selecting new or existing
                Picker(selection: $selectedOption, label: Text("")) {
                    Text("New").tag(0)
                    Text("Existing").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                // Display content based on selection
                if selectedOption == 0 {
                    NewBlendView()
                } else {
                    ExistingBlendView()
                }
            }
            .navigationBarTitle("Blend", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                isPresented = false
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(.primary)
            })
        }
    }
}

struct BlendingNewExistingView_Previews: PreviewProvider {
    @State static var isPresented = true
    
    static var previews: some View {
        BlendingNewExistingView(isPresented: $isPresented)
    }
}
