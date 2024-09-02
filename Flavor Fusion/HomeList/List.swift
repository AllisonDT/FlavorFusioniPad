//
//  List.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 3/24/24.
//

import SwiftUI
import UserNotifications

struct List: View {
    @State private var isSelecting: Bool = false
    @State private var isBlendPopupVisible: Bool = false
    @State private var isSpicePopupVisible: Bool = false
    @State private var selectedSpice: Spice?
    @ObservedObject var recipeStore = RecipeStore()
    @State private var displayName: String = UserDefaults.standard.string(forKey: "displayName") ?? "Flavor Fusion"
    @State private var isLoading: Bool = false
    @State private var lastUpdated: Date?

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    if let lastUpdated = lastUpdated, isLoading {
                        Text("Last updated: \(formattedDate(lastUpdated))")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.bottom, 10)
                    }

                    Button(action: {
                        isBlendPopupVisible.toggle()
                    }) {
                        Text("BLEND")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        VStack {
                            ForEach(firstColumnSpices) { spice in
                                SpiceRow(spice: spice, isSelecting: isSelecting, recipes: recipeStore.recipes) { selected in
                                    if let index = spiceData.firstIndex(where: { $0.id == spice.id }) {
                                        spiceData[index].isSelected = selected
                                    }
                                }
                                .onTapGesture {
                                    selectedSpice = spice
                                    isSpicePopupVisible = true
                                }
                            }
                        }
                        
                        VStack {
                            ForEach(secondColumnSpices) { spice in
                                SpiceRow(spice: spice, isSelecting: isSelecting, recipes: recipeStore.recipes) { selected in
                                    if let index = spiceData.firstIndex(where: { $0.id == spice.id }) {
                                        spiceData[index].isSelected = selected
                                    }
                                }
                                .onTapGesture {
                                    selectedSpice = spice
                                    isSpicePopupVisible = true
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
            .refreshable {
                refreshSpices()
            }
            .sheet(isPresented: $isBlendPopupVisible) {
                BlendingNewExistingView(isPresented: $isBlendPopupVisible)
            }
            .sheet(isPresented: $isSpicePopupVisible) {
                if let selectedSpice = selectedSpice {
                    SpicePopupView(spice: selectedSpice, recipes: recipeStore.recipes, isPresented: $isSpicePopupVisible)
                }
            }
            .navigationBarTitle("\(displayName)'s Cabinet", displayMode: .inline)
            .onAppear {
                requestNotificationPermission()
                checkSpiceLevels()
            }
        }
    }

    private func refreshSpices() {
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            if let savedSpiceData = UserDefaults.standard.data(forKey: "spiceData"),
               let decodedSpices = try? JSONDecoder().decode([Spice].self, from: savedSpiceData) {
                spiceData = decodedSpices
            }
            
            lastUpdated = Date()
            isLoading = false
            checkSpiceLevels() // Re-check spice levels after refreshing
        }
    }

    private func checkSpiceLevels() {
        for spice in spiceData {
            if spice.spiceAmount < 0.25 {
                triggerLowSpiceNotification(for: spice)
            }
        }
    }

    private func triggerLowSpiceNotification(for spice: Spice) {
        let content = UNMutableNotificationContent()
        content.title = "Low Spice Alert"
        content.body = "The spice '\(spice.name)' is running low at \(Int(spice.spiceAmount * 100))%."
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error triggering notification: \(error.localizedDescription)")
            } else {
                print("Low spice notification triggered for \(spice.name).")
            }
        }
    }

    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Error requesting notification permission: \(error.localizedDescription)")
            } else if granted {
                print("Notification permission granted")
            } else {
                print("Notification permission denied")
            }
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

struct List_Previews: PreviewProvider {
    static var previews: some View {
        List()
    }
}
