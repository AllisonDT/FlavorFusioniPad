//
//  CreatePasscode.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 3/25/24.
//

import SwiftUI

struct CreatePasscode: View {
    // State variables to manage passcode creation process
    @State private var passcode: String = ""
    @State private var passcodeError: Bool = false
    @State private var passcodeMatchError: Bool = false
    @State private var passcodeCreated: Bool = false
    
    // Layout for the passcode buttons
    let gridLayout = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                // If passcode not created yet
                if !passcodeCreated {
                    Text("Create a Passcode")
                        .font(.title)
                        .padding()
                    
                    // Grid of passcode buttons
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
                    
                    // Text field for passcode input
                    TextField("Passcode", text: $passcode)
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .padding()
                        // Visual indication of passcode error
                        .background(RoundedRectangle(cornerRadius: 10).stroke(passcodeError ? Color.red : Color.clear, lineWidth: 1))
                        .foregroundColor(passcodeError ? .red : .black)
                    
                    // Error message for passcode length
                    if passcodeError {
                        Text("Passcode must be at least 4 characters")
                            .foregroundColor(.red)
                            .padding(.bottom)
                    }
                    
                    // Button to create passcode
                    Button(action: createPasscode) {
                        Text("Create Passcode")
                    }
                    .padding()
                } else {
                    // Redirect to ListTabView upon successful passcode creation
                    NavigationLink(destination: ListTabView().navigationBarBackButtonHidden(true), isActive: $passcodeCreated) {
                        Text("Welcome to Flavor Fusion!")
                            .font(.title)
                            .padding()
                    }
                }
            }
            .padding()
        }
    }
    
    // Function to add a digit to the passcode
    func addToPasscode(number: String) {
        passcode += number
    }
    
    // Function to delete the last digit from the passcode
    func deleteLast() {
        if !passcode.isEmpty {
            passcode.removeLast()
        }
    }
    
    // Function to create passcode
    func createPasscode() {
        if passcode.count < 4 {
            passcodeError = true
            passcodeMatchError = false
            return
        } else {
            passcodeError = false
        }
        
        // Save passcode in UserDefaults
        UserDefaults.standard.set(passcode, forKey: "passcode")
        
        // Set passcode created flag to true
        passcodeCreated = true
    }
}

struct CreatePasscode_Previews: PreviewProvider {
    static var previews: some View {
        CreatePasscode()
    }
}
