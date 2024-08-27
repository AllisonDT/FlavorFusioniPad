//
//  ContentView.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 2/5/24.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isFirstTimeOpen") private var isFirstTimeOpen: Bool = true
    @StateObject private var bleManager = BLEManager() // Initialize BLEManager
    
    var body: some View {
        Group {
            if isFirstTimeOpen {
                CreatePasscode()
                    .onDisappear {
                        // Update the flag to indicate the app has been opened before
                        isFirstTimeOpen = false
                    }
            } else {
                LoginPasscode()
            }
        }
        .onAppear {
            // Start Bluetooth scanning when the view appears
            print("ContentView appeared. Starting BLE scanning...")
            bleManager.centralManagerDidUpdateState(bleManager.centralManager)
        }
    }
}

#Preview {
    ContentView()
}
