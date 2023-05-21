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
    @State var isConnected = false
    @State var showConnectionAlert = false
    @State var showResetAlert = false
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
                    
                    HStack {
                        Spacer()
                            .frame(width:27)
                        
                        Button("Connect") {
                            bleController.connectToSensor(type: .adafruit)
                            print("did it succeed", bleController.connectionSuccess)
                            isConnected = bleController.connectionSuccess
                            showConnectionAlert = true
                            print(isConnected)
                        }
                        .font(.system(size:19))
                        .padding()
                        .background(CustomColor.MainColor)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .padding()
                        .frame(alignment: .center)
                        .alert(isPresented: $showConnectionAlert) {
                            if isConnected {
                                return  Alert(title: Text("Successfully connected to StimuSock"), message: Text(""), dismissButton: .default(Text("OK")))
                            } else {
                                return  Alert(title: Text("Connection failed. Please try again."), message: Text(""), dismissButton: .default(Text("OK")))
                            }
                        }
                        
                        
                        if isConnected {
                            Circle()
                                .fill(.green)
                                .frame(width: 20, height: 20, alignment: .trailing)
                        } else {
                            Circle()
                                .fill(.red)
                                .frame(width: 20, height: 20, alignment: .trailing)
                        }
                        
                            
                    }
                    
                    //                Text("Battery Int: \(bleController.batteryLifeInt)")
                    //                Text("Character: \(bleController.batteryLife)")
                    //                Text("Device Name: \(bleController.deviceName)")
                    
                    Button("Reset connection") {
                        print("RESET")
                        bleController.disconnectFromDevice()
                        bleController.batteryLifeInt = 0
                        bleController.deviceName = ""
                        showResetAlert = true
                        isConnected = false
                        print(">??", isConnected)
                    }
                    .padding()
                    .font(.system(size:19))
                    .background(CustomColor.MainColor)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    .padding()
                    .alert(isPresented: $showResetAlert) {
                        Alert(title: Text("Successfully disconnected from StimuSock"), message: Text(""), dismissButton: .default(Text("OK")))
                    }
                }
                .bold()
            }
        }
        .environmentObject(bleController)
    }
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
