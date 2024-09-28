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
    @State private var bleManager: BLEManager? = nil // Declare as State and optional

    // Custom initializer
    init() {
        self.spiceDataViewModel = SpiceDataViewModel()
    }

    var body: some View {
        Group {
            if isFirstTimeOpen {
                CreatePasscode()
                    .onDisappear {
                        isFirstTimeOpen = false
                    }
            } else {
                LoginPasscode()
            }
        }
        .onAppear {
            if bleManager == nil {
                // Initialize BLEManager here to ensure that the system services are ready
                bleManager = BLEManager(spiceDataViewModel: spiceDataViewModel)
                bleManager?.centralManagerDidUpdateState(bleManager!.centralManager)
                print("ContentView appeared. Starting BLE scanning...")
            }
        }
    }
}

#Preview {
    ContentView()
}
