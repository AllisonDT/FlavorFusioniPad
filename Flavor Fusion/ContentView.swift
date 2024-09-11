//
//  ContentView.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 2/5/24.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isFirstTimeOpen") private var isFirstTimeOpen: Bool = true
    let spiceDataViewModel: SpiceDataViewModel
    let bleManager: BLEManager
    
    // Custom initializer
    init() {
        self.spiceDataViewModel = SpiceDataViewModel()
        self.bleManager = BLEManager(spiceDataViewModel: spiceDataViewModel)
    }
    
    var body: some View {
        Group {
            if isFirstTimeOpen {
                CreatePasscode()
                    .onDisappear {
                        // Update the flag to indicate the app has been opened before
                        isFirstTimeOpen = false
                    }
            } else {
                LoginPasscode() // or your main content view
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
