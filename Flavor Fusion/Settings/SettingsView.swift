//
//  SettingsView.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 3/24/24.
//

import SwiftUI

struct SettingsView: View {
    @State private var currentPasscode: String = ""
    @State private var newPasscode: String = ""
    @State private var confirmPasscode: String = ""
    @State private var isPasscodeChangeSuccessful: Bool = false
    @State private var showIncorrectPasscodeMessage: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Change Passcode")) {
                    SecureField("Current Passcode", text: $currentPasscode)
                    SecureField("New Passcode", text: $newPasscode)
                    SecureField("Confirm Passcode", text: $confirmPasscode)
                }
                
                Button(action: changePasscode) {
                    Text("Change Passcode")
                }
            }
            .navigationTitle("Settings")
            .alert(isPresented: $showIncorrectPasscodeMessage) {
                Alert(title: Text("Incorrect Passcode"), message: Text("Please enter the correct current passcode."), dismissButton: .default(Text("OK")))
            }
            .alert(isPresented: $isPasscodeChangeSuccessful) {
                Alert(title: Text("Passcode Changed"), message: Text("Your passcode has been successfully changed."), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func changePasscode() {
        // Retrieve the stored passcode from UserDefaults
        guard let storedPasscode = UserDefaults.standard.string(forKey: "passcode") else {
            print("No passcode saved.")
            // Handle the case where no passcode is saved (e.g., user hasn't set up passcode yet)
            return
        }

        // Compare the entered current passcode with the stored passcode
        if currentPasscode == storedPasscode {
            // Check if new passcode matches the confirm passcode
            if newPasscode == confirmPasscode {
                // Save the new passcode to UserDefaults
                UserDefaults.standard.set(newPasscode, forKey: "passcode")
                print("Passcode changed successfully!")
                isPasscodeChangeSuccessful = true
            } else {
                print("New passcode and confirm passcode do not match.")
                // Show an error message to the user
                showIncorrectPasscodeMessage = true // Set flag to show the incorrect passcode message
            }
        } else {
            print("Incorrect current passcode. Please try again.")
            showIncorrectPasscodeMessage = true // Set flag to show the incorrect passcode message
        }
    }
}

#Preview {
    SettingsView()
}
