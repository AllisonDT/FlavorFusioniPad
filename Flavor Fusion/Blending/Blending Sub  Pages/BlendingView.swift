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
    
    @EnvironmentObject var bleManager: BLEManager  // Access the BLEManager instance

    var body: some View {
        VStack {
            Text("Blending...")
                .font(.largeTitle)
                .padding(.top)

            ProgressView()
                .padding()

            Spacer()

            Button(action: {
                // Schedule the notification
                scheduleBlendCompletionNotification()
                
                // Simulate blending process with delay
                DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
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
            
            // Send the serialized string over Bluetooth using BLEManager
            if let serializedData = serializedIngredients.data(using: .utf8) {
                bleManager.sendSpiceDataToPeripheral(data: serializedData)
            } else {
                print("Failed to encode ingredients string.")
            }
        }
    }
    
    // Function to schedule the blend completion notification
    private func scheduleBlendCompletionNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Blend Complete!"
        content.body = "Your blend is ready. Have a spicy day!"
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 6, repeats: false)
        let request = UNNotificationRequest(identifier: "BlendCompleteNotification", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully")
            }
        }
    }
}

#Preview {
    BlendingView(spiceName: "Example Spice", servings: 1, ingredients: [
        Ingredient(name: "Salt", amount: 1.0, unit: "T")
    ], onComplete: {})
        .environmentObject(BLEManager(spiceDataViewModel: SpiceDataViewModel()))  // Provide a BLEManager instance for the preview
}
