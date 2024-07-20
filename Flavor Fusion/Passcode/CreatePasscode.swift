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
    @State private var isPasscodeCreated: Bool = false
    @State private var showPasscodeError: Bool = false
    
    // Layout for the passcode buttons
    let gridLayout = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                // Title
                Text("Create a Passcode")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .padding(.top, 50)
                
                Spacer()
                
                // Secure text field for passcode input
                SecureField("Passcode", text: $passcode)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 40)
                    .padding(.bottom, 30)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(showPasscodeError ? Color.red : Color.clear, lineWidth: 1)
                    )
                
                // Grid of passcode buttons
                LazyVGrid(columns: gridLayout, spacing: 20) {
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
                .padding(.horizontal, 40)
                
                Spacer()
                
                // Create passcode button
                Button(action: createPasscode) {
                    Text("Create Passcode")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                }
                .padding(.bottom, 40)
                
                // Error message for passcode length
                if showPasscodeError {
                    Text("Passcode must be at least 4 characters")
                        .foregroundColor(.red)
                        .padding(.bottom)
                }
            }
            .background(Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all))
            .navigationDestination(isPresented: $isPasscodeCreated) {
                ListTabView().navigationBarBackButtonHidden(true)
            }
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
            showPasscodeError = true
            return
        }
        
        // Save passcode in UserDefaults
        UserDefaults.standard.set(passcode, forKey: "passcode")
        
        // Set passcode created flag to true
        isPasscodeCreated = true
    }
}

struct CreatePasscode_Previews: PreviewProvider {
    static var previews: some View {
        CreatePasscode()
    }
}
