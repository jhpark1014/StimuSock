//
//  HomePage.swift
//  StimuSock
//
//  Created by Sarah Park on 1/28/23.
//

import SwiftUI
import CoreBluetooth
import CoreData

struct HomePage: View {
    @State var tensCounter = 0
    @State var hapticsCounter = 0
//    @State var tensButtonString = Text("Start")
//    @State var hapticsButtonString = Text("Start")
    @State var tensLevel: UInt8 = 0
    @State var frontHapticsLevel: UInt8 = 0
    @State var middleHapticsLevel: UInt8 = 0
    @State var backHapticsLevel: UInt8 = 0
    @State private var isEditing = false
    @State var tensToggle = false
    @State var hapticsToggle = false
    @State var tensSlider = 0.0
    
//    @StateObject var bleController = BLEController()
    @EnvironmentObject var bleController: BLEController
    @StateObject private var dataController = DataController()
    
    var body: some View {
        //        NavigationView {
        ZStack {
            CustomColor.BackgroundColor
                .ignoresSafeArea()
            VStack{
                if !tensToggle || !hapticsToggle {
                    Image("StimuSockIconCrop")
                    .resizable()
                    .frame(width: 200, height: 100)
//                    .padding()
                } else {
                    Image("StimuSockIconCrop")
                    .resizable()
                    .frame(width: 100, height: 50)
                    Spacer()
                        .frame(height:0)
                }
                
                List {
                    Section {
                        HStack {
                            Image("TENSIcon")
                            Toggle("Electrical Stimulation", isOn: $tensToggle)
                                .onChange(of: tensToggle) {
                                    self.tensOnOff(state: $0)
                                    tensSlider = 0.0
                                }
                                .toggleStyle(.switch)
                                .frame(width: 300.0, height: 40.0, alignment: .center)
                                .font(.system(size:27))
                        }
                        
                        if tensToggle {
                            VStack(spacing:0) {
                                Slider(
                                    value: $tensSlider,
                                    in: 0...5,
                                    step: 1
                                ) {
                                    Text("TENS")
                                } minimumValueLabel: {
                                    Text("0")
                                } maximumValueLabel: {
                                    Text("5")
                                } onEditingChanged: { editing in
                                    isEditing = editing
                                }
                                .font(.system(size:25))
                                .frame(width: 330.0, height: 30.0, alignment: .center)
                                .padding()
                                Text("\(Int(tensSlider))")
                                    .font(.system(size:25))
                            }
                            .onChange(of: tensSlider) { newValue in
                                var tensLevel = UInt8(newValue)
                                let valueString = Data([tensLevel])
                                if let blePeripheral = bleController.myPeripheral {
                                  if let tensEnableCharacteristic = bleController.tensStimCharacteristic {
                                      blePeripheral.writeValue(valueString, for: tensEnableCharacteristic, type: CBCharacteristicWriteType.withResponse)
                                      print("Printing", valueString)
                                  }
                                }
                            }
                        }
                    }
                    
                    Section {
                        HStack {
                            Image("HapticsIcon")
                            Toggle("Vibrational Haptics", isOn: $hapticsToggle)
                                .onChange(of: hapticsToggle) {
                                    self.hapticsOnOff(state: $0)
                                    frontHapticsLevel = 0
                                    middleHapticsLevel = 0
                                    backHapticsLevel = 0
                                }
                                .toggleStyle(.switch)
                                .frame(width: 300.0, height: 40.0, alignment: .center)
                                .font(.system(size:27))
                        }
                        
                        if hapticsToggle {
                            ZStack {
                                Image("FootIcon2")
                                    .resizable()
                                    .frame(width: 250.0, height: 370.0, alignment: .center)
                                    .imageScale(.large)

                                VStack{
                                    // Front
                                    Spacer()
                                        .frame(height:50)
                                    HStack{
                                        Spacer()
                                            .frame(width:35)
                                        Button("-") {
                                            // Decrease Haptics
                                            if frontHapticsLevel > 0 {
                                                frontHapticsLevel -= 1
                                            }
                                            let valueString = Data([frontHapticsLevel])
                                            if let blePeripheral = bleController.myPeripheral {
                                                if let hapticsFrontMotorCharacteristic = bleController.hapticsFrontMotorCharacteristic {
                                                    blePeripheral.writeValue(valueString, for: hapticsFrontMotorCharacteristic, type: CBCharacteristicWriteType.withResponse)
                                                    print("Printing", valueString)
                                                }
                                            }
                                        }
                                        .buttonStyle(.plain)
                                        .font(.system(size:60))
                                        .foregroundColor(CustomColor.MainColor)
                                        Spacer()
                                            .frame(width:91)

                                        Text("\(frontHapticsLevel)")
                                            .font(.system(size:35))
                                            .foregroundColor(.black)
                                        Spacer()

                                        Button("+") {
                                            // Increase Haptics
                                            if frontHapticsLevel < 5 {
                                                frontHapticsLevel += 1
                                            }
                                            let valueString = Data([frontHapticsLevel])
                                            if let blePeripheral = bleController.myPeripheral {
                                                if let hapticsFrontMotorCharacteristic = bleController.hapticsFrontMotorCharacteristic {
                                                    blePeripheral.writeValue(valueString, for: hapticsFrontMotorCharacteristic, type: CBCharacteristicWriteType.withResponse)
                                                    print("Printing", valueString)
                                                }
                                            }
                                        }
                                        .buttonStyle(.plain)
                                        .font(.system(size:60))
                                        .foregroundColor(CustomColor.MainColor)
                                        Spacer()
                                            .frame(width:25)
                                    }

                                    // Middle
                                    HStack{
                                        Spacer()
                                            .frame(width:35)
                                        Button("-") {
                                            // Decrease Haptics
                                            if middleHapticsLevel > 0 {
                                                middleHapticsLevel -= 1
                                            }
                                            let valueString = Data([middleHapticsLevel])
                                            if let blePeripheral = bleController.myPeripheral {
                                                if let hapticsMiddleMotorCharacteristic = bleController.hapticsMiddleMotorCharacteristic {
                                                    blePeripheral.writeValue(valueString, for: hapticsMiddleMotorCharacteristic, type: CBCharacteristicWriteType.withResponse)
                                                    print("Printing", valueString)
                                                }
                                            }
                                        }
                                        .buttonStyle(.plain)
                                        .font(.system(size:60))
                                        .foregroundColor(CustomColor.MainColor)
                                        Spacer()
                                            .frame(width:91)

                                        Text("\(middleHapticsLevel)")
                                            .font(.system(size:35))
                                            .foregroundColor(.black)
                                        Spacer()

                                        Button("+") {
                                            // Increase Haptics
                                            if middleHapticsLevel < 5 {
                                                middleHapticsLevel += 1
                                            }
                                            let valueString = Data([middleHapticsLevel])
                                            if let blePeripheral = bleController.myPeripheral {
                                                if let hapticsMiddleMotorCharacteristic = bleController.hapticsMiddleMotorCharacteristic {
                                                    blePeripheral.writeValue(valueString, for: hapticsMiddleMotorCharacteristic, type: CBCharacteristicWriteType.withResponse)
                                                    print("Printing", valueString)
                                                }
                                            }
                                        }
                                        .buttonStyle(.plain)
                                        .font(.system(size:60))
                                        .foregroundColor(CustomColor.MainColor)
                                        Spacer()
                                            .frame(width:25)
                                    }

                                    // Back
                                    HStack{
                                        Spacer()
                                            .frame(width:35)
                                        Button("-") {
                                            // Decrease Haptics
                                            if backHapticsLevel > 0 {
                                                backHapticsLevel -= 1
                                            }
                                            let valueString = Data([backHapticsLevel])
                                            if let blePeripheral = bleController.myPeripheral {
                                                if let hapticsBackMotorCharacteristic = bleController.hapticsBackMotorCharacteristic {
                                                    blePeripheral.writeValue(valueString, for: hapticsBackMotorCharacteristic, type: CBCharacteristicWriteType.withResponse)
                                                    print("Printing", valueString)
                                                }
                                            }
                                        }
                                        .buttonStyle(.plain)
                                        .font(.system(size:60))
                                        .foregroundColor(CustomColor.MainColor)
                                        Spacer()
                                            .frame(width:91)

                                        Text("\(backHapticsLevel)")
                                            .font(.system(size:35))
                                            .foregroundColor(.black)
                                        Spacer()

                                        Button("+") {
                                            // Increase Haptics
                                            if backHapticsLevel < 5 {
                                                backHapticsLevel += 1
                                            }
                                            let valueString = Data([backHapticsLevel])
                                            if let blePeripheral = bleController.myPeripheral {
                                                if let hapticsBackMotorCharacteristic = bleController.hapticsBackMotorCharacteristic {
                                                    blePeripheral.writeValue(valueString, for: hapticsBackMotorCharacteristic, type: CBCharacteristicWriteType.withResponse)
                                                    print("Printing", valueString)
                                                }
                                            }
                                        }
                                        .buttonStyle(.plain)
                                        .font(.system(size:60))
                                        .foregroundColor(CustomColor.MainColor)
                                        Spacer()
                                            .frame(width:25)
                                    }
                                }
                                .bold()
                            }
                        }
                    }
                }
                .background(CustomColor.BackgroundColor)
                .scrollContentBackground(.hidden)
                
//                NavigationLink(destination: Device_Stat()) {
//                    Text("Device Stat")
//                }
            }
        }
    }
    
    // Function that changes the displayed word on button
//    func tensSwitch() {
//        switch tensCounter {
//        case 0:
//            tensButtonString = Text("Stop")
//            tensCounter += 1
//            break
//
//        case 1:
//            tensButtonString = Text("Start")
//            tensCounter -= 1
//            break
//
//        default: Text("Hi")
//        }
//    }
    
//    func hapticsSwitch() {
//        switch hapticsCounter {
//        case 0:
//            hapticsButtonString = Text("Stop")
//            hapticsCounter += 1
//            break
//
//        case 1:
//            hapticsButtonString = Text("Start")
//            hapticsCounter -= 1
//            break
//
//        default: Text("Hi")
//        }
//    }
    
    func tensOnOff(state: Bool) {
//        @EnvironmentObject var bleController: BLEController
        if state{
            let valueString = Data([1])
            if let blePeripheral = bleController.myPeripheral {
                if let tensEnableCharacteristic = bleController.tensEnableCharacteristic {
                    blePeripheral.writeValue(valueString, for: tensEnableCharacteristic, type: CBCharacteristicWriteType.withResponse)
                }
            }
        } else {
            if tensCounter == 0 {
                let valueString = Data([0])
                if let blePeripheral = bleController.myPeripheral {
                    if let tensEnableCharacteristic = bleController.tensEnableCharacteristic {
                        blePeripheral.writeValue(valueString, for: tensEnableCharacteristic, type: CBCharacteristicWriteType.withResponse)
                    }
                }
            }
        }
    }
        
    func hapticsOnOff(state: Bool) {
        //        @EnvironmentObject var bleController: BLEController
        if state {
            let valueString = Data([1])
            if let blePeripheral = bleController.myPeripheral {
                if let hapticsEnableCharacteristic = bleController.hapticsEnableCharacteristic {
                    blePeripheral.writeValue(valueString, for: hapticsEnableCharacteristic, type: CBCharacteristicWriteType.withResponse)
                }
            }
        } else {
            let valueString = Data([0])
            if let blePeripheral = bleController.myPeripheral {
                if let hapticsEnableCharacteristic = bleController.hapticsEnableCharacteristic {
                    blePeripheral.writeValue(valueString, for: hapticsEnableCharacteristic, type: CBCharacteristicWriteType.withResponse)
                }
            }
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
