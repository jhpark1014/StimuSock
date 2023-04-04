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
            ZStack {
                CustomColor.BackgroundColor
                    .ignoresSafeArea()
                VStack {
                    Image("StimuSockIcon")
                        .resizable()
                        .imageScale(.small)
                        .frame(width: 300, height: 200)
                        .foregroundColor(.accentColor)
                        .padding()
                        .padding()
//                    Text("StimuSock")
//                        .font(.system(size:28))
//                        .padding()
                    NavigationLink(destination: HomePage()) {
                        Text("Start")
                            .padding(.horizontal, 40)
                            .padding(.vertical, 20)
                            .font(.system(size: 30))
                            .background(CustomColor.MainColor)
                            .foregroundColor(.white)
                            .buttonStyle(.borderedProminent)
                            .clipShape(Capsule())
                            .padding()
                            
                    }
                    Spacer()
                        .frame(width: 100, height: 80)
                    
                    Button("Connect") {
                        bleController.connectToSensor(type: .adafruit)
                        print("did it succeed", bleController.connectionSuccess)
                    }
                    .font(.system(size:19))
                    .padding()
                    .background(CustomColor.MainColor)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    .padding()
                    //                .buttonStyle(.borderedProminent)
                    
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
                    .padding()
                    .font(.system(size:19))
                    .background(CustomColor.MainColor)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    .padding()
                    
                }
                .bold()
            }
//            .environmentObject(bleController)
        }
        .environmentObject(bleController)
    }
//    .environmentObject(bleController)
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CustomColor {
    static let MainColor = Color("MainColor")
    static let BackgroundColor = Color("BackgroundColor")
}
