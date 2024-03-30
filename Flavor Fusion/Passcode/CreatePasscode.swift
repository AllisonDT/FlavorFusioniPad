//
//  LoginPasscode.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 3/25/24.
//

//
//  LoginPasscode.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 3/25/24.
//

import SwiftUI

struct CreatePasscode: View {
    @State private var passcode: String = ""
    @State private var passcodeError: Bool = false
    @State private var passcodeMatchError: Bool = false
    @State private var passcodeCreated: Bool = false
    
    let gridLayout = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                if !passcodeCreated {
                    Text("Create a Passcode")
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
                    
                    TextField("Passcode", text: $passcode)
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).stroke(passcodeError ? Color.red : Color.clear, lineWidth: 1))
                        .foregroundColor(passcodeError ? .red : .black)
                    
                    if passcodeError {
                        Text("Passcode must be at least 4 characters")
                            .foregroundColor(.red)
                            .padding(.bottom)
                    }
                    
                    Button(action: createPasscode) {
                        Text("Create Passcode")
                    }
                    .padding()
                } else {
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
    
    func addToPasscode(number: String) {
        passcode += number
    }
    
    func deleteLast() {
        if !passcode.isEmpty {
            passcode.removeLast()
        }
    }
    
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
