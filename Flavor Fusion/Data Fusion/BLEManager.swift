//
//  BLEManager.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 5/11/24.
//

import Foundation
import CoreBluetooth

class BLEManager: NSObject, ObservableObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    @Published var isDataRetrievedViaBluetooth: Bool = false
    var centralManager: CBCentralManager!
    var connectedPeripheral: CBPeripheral?
    
    var spiceDataViewModel: SpiceDataViewModel

    // Define your service and characteristic UUIDs
    let spiceServiceUUID = CBUUID(string: "180C")
    let containerNumberCharacteristicUUID = CBUUID(string: "2A56")
    let spiceAmountCharacteristicUUID = CBUUID(string: "2A57")
    let serializedIngredientsCharacteristicUUID = CBUUID(string: "2A58")
    
    private var currentContainerNumber: Int?
    private var expectedNumberOfContainers: Int = 10
    private var receivedContainersCount: Int = 0
    
    init(spiceDataViewModel: SpiceDataViewModel) {
        self.spiceDataViewModel = spiceDataViewModel
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
        print("Central Manager initialized.")
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("Central Manager did update state: \(central.state.rawValue)")
        
        if central.state == .poweredOn {
            print("Bluetooth is powered on. Starting scan for peripherals...")
            centralManager.scanForPeripherals(withServices: [spiceServiceUUID], options: nil)
        } else {
            print("Bluetooth is not available.")
            useExampleDataIfNeeded()
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print("Discovered peripheral: \(peripheral.name ?? "Unknown") with RSSI: \(RSSI)")
        connectedPeripheral = peripheral
        centralManager.stopScan()
        print("Stopped scanning. Connecting to peripheral: \(peripheral.name ?? "Unknown")")
        centralManager.connect(peripheral, options: nil)
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected to peripheral: \(peripheral.name ?? "Unknown"). Discovering services...")
        peripheral.delegate = self
        peripheral.discoverServices([spiceServiceUUID])
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let error = error {
            print("Error discovering services: \(error.localizedDescription)")
            return
        }
        
        print("Discovered services for peripheral: \(peripheral.name ?? "Unknown").")
        if let services = peripheral.services {
            for service in services {
                print("Service UUID: \(service.uuid)")
                if service.uuid == spiceServiceUUID {
                    print("Found spice service. Discovering characteristics...")
                    peripheral.discoverCharacteristics([containerNumberCharacteristicUUID, spiceAmountCharacteristicUUID, serializedIngredientsCharacteristicUUID], for: service)
                }
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let error = error {
            print("Error discovering characteristics: \(error.localizedDescription)")
            return
        }
        
        print("Discovered characteristics for service: \(service.uuid).")
        if let characteristics = service.characteristics {
            for characteristic in characteristics {
                print("Characteristic UUID: \(characteristic.uuid)")
                if characteristic.uuid == containerNumberCharacteristicUUID || characteristic.uuid == spiceAmountCharacteristicUUID {
                    print("Enabling notifications for characteristic: \(characteristic.uuid)")
                    peripheral.setNotifyValue(true, for: characteristic)
                }
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let error = error {
            print("Error updating value for characteristic: \(error.localizedDescription)")
            return
        }
        
        print("Received update for characteristic: \(characteristic.uuid).")
        if let data = characteristic.value {
            print("Data received: \(data as NSData)")
            isDataRetrievedViaBluetooth = true
            processData(characteristic: characteristic, data: data)
        } else {
            print("No data received. Using example data.")
            useExampleDataIfNeeded()
        }
    }
    
    private func processData(characteristic: CBCharacteristic, data: Data) {
        if characteristic.uuid == containerNumberCharacteristicUUID {
            let containerNumber = Int(data[0])
            print("Processed container number: \(containerNumber)")
            currentContainerNumber = containerNumber
        } else if characteristic.uuid == spiceAmountCharacteristicUUID, let containerNumber = currentContainerNumber {
            let spiceAmount = data.withUnsafeBytes { $0.load(as: Float.self) }
            print("Processed spice amount: \(spiceAmount)")
            updateSpiceData(containerNumber: containerNumber, spiceAmount: Double(spiceAmount))
            receivedContainersCount += 1
            currentContainerNumber = nil
            
            if receivedContainersCount == expectedNumberOfContainers {
                print("All data received for \(expectedNumberOfContainers) containers.")
                completeDataTransfer()
            }
        }
    }

    private func updateSpiceData(containerNumber: Int, spiceAmount: Double) {
        print("Updating spice data for container number: \(containerNumber) with amount: \(spiceAmount) grams.")
        spiceDataViewModel.updateSpice(containerNumber: containerNumber, newAmountInGrams: spiceAmount)
    }

    private func completeDataTransfer() {
        // Stop notifications
        if let peripheral = connectedPeripheral {
            if let characteristics = peripheral.services?.first(where: { $0.uuid == spiceServiceUUID })?.characteristics {
                for characteristic in characteristics {
                    if characteristic.uuid == containerNumberCharacteristicUUID || characteristic.uuid == spiceAmountCharacteristicUUID {
                        print("Disabling notifications for characteristic: \(characteristic.uuid)")
                        peripheral.setNotifyValue(false, for: characteristic)
                    }
                }
            }
            // Disconnect from the peripheral
//            centralManager.cancelPeripheralConnection(peripheral)
//            print("Disconnected from peripheral: \(peripheral.name ?? "Unknown").")
        }
        
        print("All data processed. UI should be updated accordingly.")
    }

    // New method to send data
    func sendSpiceDataToPeripheral(data: Data) {
        guard let peripheral = connectedPeripheral else {
            print("No connected peripheral to send data to.")
            return
        }
        
        if let serializedIngredientsCharacteristic = getCharacteristic(peripheral: peripheral, uuid: serializedIngredientsCharacteristicUUID) {
            let chunkSize = 20  // Adjust as necessary for your Bluetooth characteristic size
            var offset = 0
            
            while offset < data.count {
                let chunkLength = min(chunkSize, data.count - offset)
                let chunk = data.subdata(in: offset..<offset + chunkLength)
                
                // Send this chunk over Bluetooth
                peripheral.writeValue(chunk, for: serializedIngredientsCharacteristic, type: .withResponse)
                print("Sending chunk: \(String(data: chunk, encoding: .utf8) ?? "Error")")
                
                offset += chunkLength
            }
            
            print("All data has been sent.")
            
        } else {
            print("Could not find characteristic to send serialized ingredients data.")
        }
    }
    
    private func getCharacteristic(peripheral: CBPeripheral, uuid: CBUUID) -> CBCharacteristic? {
        return peripheral.services?.first(where: { $0.uuid == spiceServiceUUID })?.characteristics?.first(where: { $0.uuid == uuid })
    }
    
    private func useExampleDataIfNeeded() {
        if !isDataRetrievedViaBluetooth {
            print("Using example data as no Bluetooth data was retrieved.")
            // You could do any additional processing or UI updates here if needed
        }
    }
}
