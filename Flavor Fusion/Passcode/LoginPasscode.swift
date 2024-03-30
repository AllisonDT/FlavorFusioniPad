//
//  LoginPasscode.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 3/25/24.
//

import SwiftUI
import CryptoKit

struct LoginPasscode: View {
    @State private var passcode: String = ""
    @State private var isLoginSuccessful: Bool = false
    @State private var showIncorrectPasscodeMessage: Bool = false

    let gridLayout = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Enter Passcode")
                    .font(.title)
                    .padding()
                
                LazyVGrid(columns: gridLayout, spacing: 10) {
                    ForEach(1...9, id: \.self) { number in
                        PasscodeButton(number: "\(number)") {
                            addToPasscode(number: "\(number)")
                        }
                    }
                    Spacer()
                    PasscodeButton(number: "Del") {
                        deleteLast()
                    }
                }
                .padding(.horizontal)
                
                SecureField("Passcode", text: $passcode)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: login) {
                    Text("Login")
                }
                .padding()
                
                NavigationLink(destination: ListTabView().navigationBarBackButtonHidden(true), isActive: $isLoginSuccessful) {
                    EmptyView()
                }
            }
            .padding()
            .alert(isPresented: $showIncorrectPasscodeMessage) {
                Alert(title: Text("Incorrect Passcode"), message: Text("Please try again."), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func addToPasscode(number: String) {
        passcode += number
    }
    
    func deleteLast() {
        if !passcode.isEmpty {
            passcode.removeLast()
        }
    }
    
    func login() {
        // Retrieve the stored passcode from UserDefaults
        guard let storedPasscode = UserDefaults.standard.string(forKey: "passcode") else {
            print("No passcode saved.")
            // Handle the case where no passcode is saved (e.g., user hasn't set up passcode yet)
            return
        }

        // Compare the entered passcode with the stored passcode
        if passcode == storedPasscode {
            print("Login successful!")
            isLoginSuccessful = true // Navigate to ListTabView
        } else {
            print("Incorrect passcode. Please try again.")
            // Clear the passcode text field
            passcode = ""
            showIncorrectPasscodeMessage = true // Set flag to show the incorrect passcode message
        }
    }


}

struct LoginPasscode_Previews: PreviewProvider {
    static var previews: some View {
        LoginPasscode()
    }
}
