//
//  ContentView.swift
//  StimuSock
//
//  Created by Sarah Park on 1/28/23.
//

import SwiftUI
import CoreBluetooth

struct ContentView: View {
    @StateObject var bleController = BLEController()
    @State private var showAlert = false
    public var writtenText: String = ""
//    @ObservedObject var batteryPercent: UInt16!
    
    var body: some View {
        NavigationView {
            VStack {
                Image("SockIcon")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("StimuSock")
                    .font(.system(size:25))
                
                NavigationLink(destination: HomePage()) {
                    Text("Start")
                        .font(.system(size:23))
//                        .padding()
                }

                Button("Connect") {
                    bleController.connectToSensor(type: .adafruit)
                    print("did it succeed", bleController.connectionSuccess)
                }
                .font(.system(size:23))
                .padding()
                
//                Text("Battery Int: \(bleController.batteryLifeInt)")
//                Text("Character: \(bleController.batteryLife)")
//                Text("Device Name: \(bleController.deviceName)")
                
//                Button("Start TENS") {
//                    print("Signaling")
//                    let valueString = Data([1])
//                    if let blePeripheral = bleController.myPeripheral {
//                      if let tensEnableCharacteristic = bleController.tensEnableCharacteristic {
//                          blePeripheral.writeValue(valueString, for: tensEnableCharacteristic, type: CBCharacteristicWriteType.withResponse)
//                      }
//                    }
//                }
//
//                Button("Stop TENS") {
//                    print("Signaling")
//                    let valueString = Data([0])
//                    if let blePeripheral = bleController.myPeripheral {
//                      if let tensEnableCharacteristic = bleController.tensEnableCharacteristic {
//                          blePeripheral.writeValue(valueString, for: tensEnableCharacteristic, type: CBCharacteristicWriteType.withResponse)
//                      }
//                    }
//                }
//                .padding()
                
                Button("Reset connection") {
                    print("RESET")
                    bleController.disconnectFromDevice()
                    bleController.batteryLifeInt = 0
                    bleController.deviceName = ""
                }
                .font(.system(size:23))
            }
            .bold()
        }
        .environmentObject(bleController)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
