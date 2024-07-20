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
    
    @State private var displayName: String = UserDefaults.standard.string(forKey: "displayName") ?? ""
    @State private var isDisplayNameChangeSuccessful: Bool = false
    
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
                
                Section(header: Text("Change Display Name")) {
                    TextField("Display Name", text: $displayName)
                }
                
                Button(action: changeDisplayName) {
                    Text("Change Display Name")
                }
            }
            .navigationTitle("Settings")
            .alert(isPresented: $showIncorrectPasscodeMessage) {
                Alert(title: Text("Incorrect Passcode"), message: Text("Please enter the correct current passcode."), dismissButton: .default(Text("OK")))
            }
            .alert(isPresented: $isPasscodeChangeSuccessful) {
                Alert(title: Text("Passcode Changed"), message: Text("Your passcode has been successfully changed."), dismissButton: .default(Text("OK")))
            }
            .alert(isPresented: $isDisplayNameChangeSuccessful) {
                Alert(title: Text("Display Name Changed"), message: Text("Your display name has been successfully changed."), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func changePasscode() {
        guard let storedPasscode = UserDefaults.standard.string(forKey: "passcode") else {
            print("No passcode saved.")
            return
        }

        if currentPasscode == storedPasscode {
            if newPasscode == confirmPasscode {
                UserDefaults.standard.set(newPasscode, forKey: "passcode")
                print("Passcode changed successfully!")
                isPasscodeChangeSuccessful = true
            } else {
                print("New passcode and confirm passcode do not match.")
                showIncorrectPasscodeMessage = true
            }
        } else {
            print("Incorrect current passcode. Please try again.")
            showIncorrectPasscodeMessage = true
        }
    }
    
    func changeDisplayName() {
        UserDefaults.standard.set(displayName, forKey: "displayName")
        isDisplayNameChangeSuccessful = true
    }
}

#Preview {
    SettingsView()
}
