//
//  HomePage.swift
//  StimuSock
//
//  Created by Sarah Park on 1/28/23.
//

import SwiftUI
import CoreBluetooth

struct HomePage: View {
    @State var tensCounter = 0
    @State var hapticsCounter = 0
    @State var tensButtonString = Text("Start")
    @State var hapticsButtonString = Text("Start")
    @State var tensLevel: UInt8 = 0
    @State var frontHapticsLevel: UInt8 = 0
    @State var middleHapticsLevel: UInt8 = 0
    @State var backHapticsLevel: UInt8 = 0
    @State private var isEditing = false
    @State var tensToggle = false
    @State var hapticsToggle = false
    
    @State var tensSlider = 0.0
    @State var hapticsSlider = 0.0
    @State var frontSlider = 0.0
    @State var middleSlider = 0.0
    @State var backSlider = 0.0
    
//    @StateObject var bleController = BLEController()
    @EnvironmentObject var bleController: BLEController
    
    var body: some View {
        //        NavigationView {
        ZStack {
            CustomColor.BackgroundColor
                .ignoresSafeArea()
            VStack{
                Image("StimuSockIconCrop")
//                    .font(.system(size:25))
                    .resizable()
                    .frame(width: 200, height: 100)
                    .padding()
                //            Image("SockIcon")
                //            Button("\(tensButtonString) TENS") {
                //                // Turn on/off device
                //                tensSwitch()
                //
                //                // Turn TENS on
                //                if tensCounter == 1 {
                //                    let valueString = Data([1])
                //                    if let blePeripheral = bleController.myPeripheral {
                //                        if let tensEnableCharacteristic = bleController.tensEnableCharacteristic {
                //                            blePeripheral.writeValue(valueString, for: tensEnableCharacteristic, type: CBCharacteristicWriteType.withResponse)
                //                        }
                //                    }
                //                }
                //
                //                // Turn TENS off
                //                if tensCounter == 0 {
                //                    let valueString = Data([0])
                //                    if let blePeripheral = bleController.myPeripheral {
                //                        if let tensEnableCharacteristic = bleController.tensEnableCharacteristic {
                //                            blePeripheral.writeValue(valueString, for: tensEnableCharacteristic, type: CBCharacteristicWriteType.withResponse)
                //                        }
                //                    }
                //                }
                //            }
                //            .font(.system(size:25))
                
                Toggle("TENS", isOn: $tensToggle)
//                    .onChange(of: tensToggle) {
//                        self.tensOnOff(state: $0)
//                    }
                    .toggleStyle(.switch)
                    .frame(width: 350.0, height: 30.0, alignment: .center)
                    .font(.system(size:23))
                
                if tensToggle {
                    HStack{
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
                        .font(.system(size:20))
                        .frame(width: 350.0, height: 30.0, alignment: .center)
                        .padding()
                    }
                    //                tensOn()
                    Text("\(Int(tensSlider))")
                        .font(.system(size:20))
                }
                
                //            Button("\(hapticsButtonString) Haptics") {
                //                // Turn on/off device
                //                hapticsSwitch()
                //
                //                // Turn Haptics on
                //                if hapticsCounter == 1 {
                //                    let valueString = Data([1])
                //                    if let blePeripheral = bleController.myPeripheral {
                //                        if let hapticsEnableCharacteristic = bleController.hapticsEnableCharacteristic {
                //                            blePeripheral.writeValue(valueString, for: hapticsEnableCharacteristic, type: CBCharacteristicWriteType.withResponse)
                //                        }
                //                    }
                //                }
                //
                //                // Turn Haptics off
                //                if hapticsCounter == 0 {
                //                    let valueString = Data([0])
                //                    if let blePeripheral = bleController.myPeripheral {
                //                        if let hapticsEnableCharacteristic = bleController.hapticsEnableCharacteristic {
                //                            blePeripheral.writeValue(valueString, for: hapticsEnableCharacteristic, type: CBCharacteristicWriteType.withResponse)
                //                        }
                //                    }
                //                }
                //            }
                //            .font(.system(size:25))
                //            .padding()
                
                Toggle("Haptics", isOn: $hapticsToggle)
//                    .onChange(of: hapticsToggle) {
//                        self.hapticsOnOff(state: $0)
//                    }
                    .toggleStyle(.switch)
                    .frame(width: 350.0, height: 30.0, alignment: .center)
                    .font(.system(size:23))
                
                if hapticsToggle {
                    Group {
                        HStack(spacing:0){
                            Image("FootIcon2")
                                .resizable()
                                .frame(width: 250.0, height: 370.0, alignment: .center)
//                                .position(x: 200, y: 200)
                                .imageScale(.large)
                            
                            VStack(spacing:0){
                                VStack(spacing:0){
                                    Text("Front Motor")
                                    Slider(
                                        value: $frontSlider,
                                        in: 0...5,
                                        step: 1
                                    ) {
                                        Text("Haptics")
                                    } minimumValueLabel: {
                                        Text("0")
                                    } maximumValueLabel: {
                                        Text("5")
                                    } onEditingChanged: { editing in
                                        isEditing = editing
                                    }
                                    .font(.system(size:20))
                                    .frame(width: 150.0, height: 30.0, alignment: .center)
                                    Text("\(Int(frontSlider))")
                                }
                                .position(x: 65, y: 100)

                                VStack(spacing:0){
                                    Text("Back Motor")
                                    Slider(
                                        value: $backSlider,
                                        in: 0...5,
                                        step: 1
                                    ) {
                                        Text("Haptics")
                                    } minimumValueLabel: {
                                        Text("0")
                                    } maximumValueLabel: {
                                        Text("5")
                                    } onEditingChanged: { editing in
                                        isEditing = editing
                                    }
                                    .font(.system(size:20))
                                    .frame(width: 150.0, height: 30.0, alignment: .center)
                                    //                            .position(x: 10, y: 100)
                                    //                    .padding()
                                    Text("\(Int(backSlider))")
                                    //                            .font(.system(size:20))
                                }
                                .position(x: 65, y: 0)
                            }
                        }
                    }
                }
                
                
                // 그그 tens plus minus
                //            HStack{
                //                Text("TENS")
                //                Button("-") {
                //                    // Decrease TENS
                //                    if tensLevel > 0 {
                //                        tensLevel -= 1
                //                    }
                //                    let valueString = Data([tensLevel])
                //                    if let blePeripheral = bleController.myPeripheral {
                //                      if let tensEnableCharacteristic = bleController.tensStimCharacteristic {
                //                          blePeripheral.writeValue(valueString, for: tensEnableCharacteristic, type: CBCharacteristicWriteType.withResponse)
                //                          print("Printing", valueString)
                //                      }
                //                    }
                //                }
                //                Text("\(tensLevel)")
                //                // Get mA from bluetooth and display
                //                Button("+") {
                //                    // Increase TENS
                //                    if tensLevel < 5 {
                //                        tensLevel += 1
                //                    }
                //                    let valueString = Data([tensLevel])
                //                    if let blePeripheral = bleController.myPeripheral {
                //                      if let tensEnableCharacteristic = bleController.tensStimCharacteristic {
                //                          blePeripheral.writeValue(valueString, for: tensEnableCharacteristic, type: CBCharacteristicWriteType.withResponse)
                //                          print("Printing", valueString)
                //                      }
                //                    }
                //                }
                //            }
                //            .padding()
                //            .font(.system(size:25))
                
                
                // Front Motor
                //            HStack{
                //                Text("Front Motor")
                //                Button("-") {
                //                    // Decrease Haptics
                //                    if frontHapticsLevel > 0 {
                //                        frontHapticsLevel -= 1
                //                    }
                //                    let valueString = Data([frontHapticsLevel])
                //                    if let blePeripheral = bleController.myPeripheral {
                //                      if let hapticsFrontMotorCharacteristic = bleController.hapticsFrontMotorCharacteristic {
                //                          blePeripheral.writeValue(valueString, for: hapticsFrontMotorCharacteristic, type: CBCharacteristicWriteType.withResponse)
                //                          print("Printing", valueString)
                //                      }
                //                    }
                //                }
                //                Text("\(frontHapticsLevel)")
                //                // Get frequency from bluetooth and display
                //                Button("+") {
                //                    // Increase Haptics
                //                    if frontHapticsLevel < 5 {
                //                        frontHapticsLevel += 1
                //                    }
                //                    let valueString = Data([frontHapticsLevel])
                //                    if let blePeripheral = bleController.myPeripheral {
                //                      if let hapticsFrontMotorCharacteristic = bleController.hapticsFrontMotorCharacteristic {
                //                          blePeripheral.writeValue(valueString, for: hapticsFrontMotorCharacteristic, type: CBCharacteristicWriteType.withResponse)
                //                          print("Printing", valueString)
                //                      }
                //                    }
                //                }
                //            }
                //            .font(.system(size:25))
                
                // Middle Motor
                //            HStack{
                //                Text("Middle Motor")
                //                Button("-") {
                //                    // Decrease Haptics
                //                    if middleHapticsLevel > 0 {
                //                        middleHapticsLevel -= 1
                //                    }
                //                    let valueString = Data([middleHapticsLevel])
                //                    if let blePeripheral = bleController.myPeripheral {
                //                      if let hapticsMiddleMotorCharacteristic = bleController.hapticsMiddleMotorCharacteristic {
                //                          blePeripheral.writeValue(valueString, for: hapticsMiddleMotorCharacteristic, type: CBCharacteristicWriteType.withResponse)
                //                          print("Printing", valueString)
                //                      }
                //                    }
                //                }
                //                Text("\(middleHapticsLevel)")
                //                // Get frequency from bluetooth and display
                //                Button("+") {
                //                    // Increase Haptics
                //                    if middleHapticsLevel < 5 {
                //                        middleHapticsLevel += 1
                //                    }
                //                    let valueString = Data([middleHapticsLevel])
                //                    if let blePeripheral = bleController.myPeripheral {
                //                      if let hapticsMiddleMotorCharacteristic = bleController.hapticsMiddleMotorCharacteristic {
                //                          blePeripheral.writeValue(valueString, for: hapticsMiddleMotorCharacteristic, type: CBCharacteristicWriteType.withResponse)
                //                          print("Printing", valueString)
                //                      }
                //                    }
                //                }
                //            }
                //            .font(.system(size:25))
                
                // Back Motor
                //            HStack{
                //                Text("Back Motor")
                //                Button("-") {
                //                    // Decrease Haptics
                //                    if backHapticsLevel > 0 {
                //                        backHapticsLevel -= 1
                //                    }
                //                    let valueString = Data([backHapticsLevel])
                //                    if let blePeripheral = bleController.myPeripheral {
                //                      if let hapticsBackMotorCharacteristic = bleController.hapticsBackMotorCharacteristic {
                //                          blePeripheral.writeValue(valueString, for: hapticsBackMotorCharacteristic, type: CBCharacteristicWriteType.withResponse)
                //                          print("Printing", valueString)
                //                      }
                //                    }
                //                }
                //                Text("\(backHapticsLevel)")
                //                // Get frequency from bluetooth and display
                //                Button("+") {
                //                    // Increase Haptics
                //                    if backHapticsLevel < 5 {
                //                        backHapticsLevel += 1
                //                    }
                //                    let valueString = Data([backHapticsLevel])
                //                    if let blePeripheral = bleController.myPeripheral {
                //                      if let hapticsBackMotorCharacteristic = bleController.hapticsBackMotorCharacteristic {
                //                          blePeripheral.writeValue(valueString, for: hapticsBackMotorCharacteristic, type: CBCharacteristicWriteType.withResponse)
                //                          print("Printing", valueString)
                //                      }
                //                    }
                //                }
                //            }
                //            .font(.system(size:25))
                
                //            NavigationLink(destination: Device_Stat()) {
                //                Text("Device Stat")
                //            }
            }
            //        .environmentObject(bleController)
        }
    }
    
    // Function that changes the displayed word on button
    func tensSwitch() {
        switch tensCounter {
        case 0:
            tensButtonString = Text("Stop")
            tensCounter += 1
            break
            
        case 1:
            tensButtonString = Text("Start")
            tensCounter -= 1
            break
            
        default: Text("Hi")
        }
//        print(buttonCounter)
    }
    
    func hapticsSwitch() {
        switch hapticsCounter {
        case 0:
            hapticsButtonString = Text("Stop")
            hapticsCounter += 1
            break
            
        case 1:
            hapticsButtonString = Text("Start")
            hapticsCounter -= 1
            break
            
        default: Text("Hi")
        }
//        print(buttonCounter)
    }
    
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
