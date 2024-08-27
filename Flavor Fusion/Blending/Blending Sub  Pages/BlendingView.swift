//
//  BlendingView.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 7/13/24.
//

import SwiftUI

/// A view that displays a blending progress message and a button to complete the blending process.
///
/// `BlendingView` shows a "Blending..." message, a progress indicator, and a "Complete Blending" button.
/// When the button is pressed, the blending process is simulated with a delay before calling the `onComplete` closure.
///
/// - Parameters:
///   - onComplete: A closure that is called when the blending process is completed.
struct BlendingView: View {
    let spiceName: String
    let servings: Int
    let ingredients: [Ingredient]
    let onComplete: () -> Void

    var body: some View {
        VStack {
            Text("Blending...")
                .font(.largeTitle)
                .padding(.top)

            ProgressView()
                .padding()

            Spacer()

            Button(action: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    onComplete()
                }
            }) {
                Text("Complete Blending")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .shadow(radius: 10)
            }
            .padding()
        }
        .padding()
        .onAppear {
            print("Spice Name: \(spiceName)")
            print("Servings: \(servings)")
            print("Ingredients:")
            for ingredient in ingredients {
                print("- \(ingredient.name): \(ingredient.amount)")
            }
            
            // Serialize the ingredients array to a custom delimited string
            let serializedIngredients = ingredients.map { "\($0.name):\($0.amount)" }.joined(separator: ";")
            
            print("Serialized Ingredients String: \(serializedIngredients)")
            print("Size of Serialized String in bytes: \(serializedIngredients.lengthOfBytes(using: .utf8))")
            
            // Send the serialized string over Bluetooth in chunks if necessary
            if let serializedData = serializedIngredients.data(using: .utf8) {
                sendInChunks(data: serializedData)
            } else {
                print("Failed to encode ingredients string.")
            }
        }
    }
    
    // Function to send data over Bluetooth in chunks
    func sendInChunks(data: Data, chunkSize: Int = 20) {
        var offset = 0
        
        while offset < data.count {
            let chunkLength = min(chunkSize, data.count - offset)
            let chunk = data.subdata(in: offset..<offset + chunkLength)
            
            // Send this chunk over Bluetooth
            sendChunkOverBluetooth(chunk)
            
            offset += chunkLength
        }
    }
    
    // Function to simulate sending a chunk over Bluetooth (replace with actual Bluetooth sending code)
    func sendChunkOverBluetooth(_ chunk: Data) {
        // Your Bluetooth sending code here
        print("Sending chunk: \(String(data: chunk, encoding: .utf8) ?? "Error")")
    }
}

#Preview {
    BlendingView(spiceName: "Example Spice", servings: 1, ingredients: [
        Ingredient(name: "Salt", amount: 1.0, unit: "T")
    ], onComplete: {})
}
