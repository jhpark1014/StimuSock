//
//  Bluetooth.swift
//  StimuSock
//
//  Created by Sarah Park on 2/4/23.
//

import Foundation
import CoreBluetooth

class BLEController: NSObject, ObservableObject, CBCentralManagerDelegate, CBPeripheralDelegate {
   
    var myCentral: CBCentralManager!
   
    @Published var isSwitchedOn = false
    @Published var myPeripheral: CBPeripheral!
    @Published var writeCharacteristic: CBCharacteristic!
    @Published var readCharacteristic: CBCharacteristic!
    @Published var batteryCharacteristic: CBCharacteristic!
    @Published var tensEnableCharacteristic: CBCharacteristic!
    @Published var tensStimCharacteristic: CBCharacteristic!
    @Published var hapticsEnableCharacteristic: CBCharacteristic!
    @Published var hapticsFrontMotorCharacteristic: CBCharacteristic!
    @Published var hapticsMiddleMotorCharacteristic: CBCharacteristic!
    @Published var hapticsBackMotorCharacteristic: CBCharacteristic!
   
    // Battery UUID
    let batteryService_UUID = CBUUID(string: "180F")
    let batteryCharacteristic_UUID = CBUUID(string: "2A19")
    
    // Read/Write UUID
    let UARTService_UUID = CBUUID(string: "6e400001-b5a3-f393-e0a9-e50e24dcca9e")
    let UARTReadCharacteristic_UUID = CBUUID(string: "6E400003-B5A3-F393-E0A9-E50E24DCCA9E")
    let UARTWriteCharacteristic_UUID = CBUUID(string: "6E400002-B5A3-F393-E0A9-E50E24DCCA9E")
    
    // TENS UUID
    let tensService_UUID = CBUUID(string: "adb80d3d-a839-4b7e-9d05-de4e29d67f08")
    let tensEnableCharacteristic_UUID = CBUUID(string: "fd5eb58b-bf4b-449a-98c8-e97f6ef5a31d")
    let tensCurrent_UUID = CBUUID(string: "002855c9-002f-41f7-881c-b4515ed52086")
    
    // Haptics UUID
    let hapticsService_UUID = CBUUID(string: "68681fe8-c609-44e6-9080-a7a9ea7fefed")
    let hapticsEnableCharacteristic_UUID = CBUUID(string: "aa39a9e1-be7c-4e3f-a236-c606ae82184f")
    let hapticsFrontMotor_UUID = CBUUID(string: "b354d0e4-2142-41e5-8d6b-d863d282cb61")
    let hapticsMiddleMotor_UUID = CBUUID(string: "48082aa7-7364-4248-bdc0-7a8e8c25d26a")
    let hapticsBackMotor_UUID = CBUUID(string: "a70335ad-3371-4fed-8b8c-c4bc84bd5015")
    
   
    override init() {
        super.init()
        myCentral = CBCentralManager(delegate: self, queue: nil)
    }
   
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            isSwitchedOn = true
        }
        else {
            isSwitchedOn = false
        }
    }
    
    @Published var TENS: UInt16 = 0
    @Published var hapticsFrequency: UInt16 = 0
    @Published var batteryLife: String = ""
    @Published var batteryLifeInt: UInt8 = 0
    @Published var deviceName: String = ""
    @Published var connectionSuccess = false
    @Published var stimulation: UInt8 = 0
    
    var sensorType: RTSensorType!

    func connectToSensor(type: RTSensorType) {
        sensorType = type
        var serviceUUIDs: [CBUUID] = []
       
        switch sensorType {
        case .adafruit:
            serviceUUIDs = [tensService_UUID]
            print("adafruit")
        case .none:
            serviceUUIDs = []
        }
       
        myCentral.scanForPeripherals(withServices: serviceUUIDs, options: nil)
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
//        print("successsssss")
        sensors.append(RTSensor(peripheral: peripheral, name: peripheral.name ?? "NoName", type: sensorType, isConnected: false))
//        print(sensors)
        sensors.last!.peripheral.delegate = self
        central.stopScan()
//        self.peripheral = peripheral
        myPeripheral = peripheral
        myPeripheral.delegate = self
        central.connect(myPeripheral, options: nil)
        print("name: ", myPeripheral.name)
        deviceName = myPeripheral.name!
        if deviceName != "" {
            connectionSuccess = true
        }
        print("deviceName: ", deviceName)
        print("success")
//        print(sensors)
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.delegate = self
//        print("Come")
//        myPeripheral.discoverServices(nil)
        myPeripheral.discoverServices([batteryService_UUID])
//        myPeripheral.discoverServices([UARTService_UUID])
        myPeripheral.discoverServices([tensService_UUID])
        myPeripheral.discoverServices([hapticsService_UUID])
//        peripheral.discoverServices(nil)
//        peripheral.discoverCharacteristics([batteryCharacteristic_UUID], for: (peripheral.services?.last)!)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else {return}
        print("services: ", peripheral.services)
        for service in services {
//            print(services.last!)
//            peripheral.discoverCharacteristics(nil, for: services.last!)
            if service.uuid.isEqual(batteryService_UUID) {
                peripheral.discoverCharacteristics(nil, for: service)
            }
//            if service.uuid.isEqual(UARTService_UUID) {
//                peripheral.discoverCharacteristics(nil, for: service)
//            }
            if service.uuid.isEqual(tensService_UUID) {
                peripheral.discoverCharacteristics(nil, for: service)
            }
            if service.uuid.isEqual(hapticsService_UUID) {
                peripheral.discoverCharacteristics(nil, for: service)
            }
        }
    }
    
    func readvalue(peripheral: CBPeripheral, characteristic: CBCharacteristic) {
        peripheral.setNotifyValue(true, for: characteristic)
        peripheral.readValue(for: characteristic)
        print("Characteristic uuid: \(characteristic.uuid)")
    }
    
    // ㅠㅠㅠㅠㅠㅠㅠ
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else {return}
        print("Found \(characteristics.count) characteristics.")

        for characteristic in characteristics {

//          if characteristic.uuid.isEqual(UARTWriteCharacteristic_UUID) {
//            writeCharacteristic = characteristic
//            BlePeripheral.connectedWriteChar = writeCharacteristic
//            print("Write Characteristic: \(writeCharacteristic.uuid)")
//          }

//          if characteristic.uuid.isEqual(UARTReadCharacteristic_UUID){
//            readCharacteristic = characteristic
//            BlePeripheral.connectedReadChar = readCharacteristic
//            peripheral.setNotifyValue(true, for: readCharacteristic!)
//            peripheral.readValue(for: characteristic)
//            print("Read Characteristic: \(readCharacteristic.uuid)")
//          }
            
            // Battery
          if characteristic.uuid.isEqual(batteryCharacteristic_UUID){
            batteryCharacteristic = characteristic
            BlePeripheral.connectedBatteryChar = batteryCharacteristic
            peripheral.setNotifyValue(false, for: characteristic)
            peripheral.readValue(for: characteristic)
            print("Battery Characteristic: \(batteryCharacteristic.uuid)")
          }
            
            // Enable TENS
            if characteristic.uuid.isEqual(tensEnableCharacteristic_UUID){
                tensEnableCharacteristic = characteristic
              BlePeripheral.enableTENSChar = tensEnableCharacteristic
              peripheral.setNotifyValue(false, for: characteristic)
              peripheral.readValue(for: characteristic)
              print("TENS Enable Characteristic: \(tensEnableCharacteristic.uuid)")
            }
            
            // TENS Stimulation
            if characteristic.uuid.isEqual(tensCurrent_UUID){
                tensStimCharacteristic = characteristic
              BlePeripheral.tensStimChar = tensStimCharacteristic
              peripheral.setNotifyValue(false, for: characteristic)
              peripheral.readValue(for: characteristic)
              print("TENS Stim Characteristic: \(tensStimCharacteristic.uuid)")
            }
            
            // Enable Haptics
            if characteristic.uuid.isEqual(hapticsEnableCharacteristic_UUID){
                hapticsEnableCharacteristic = characteristic
              BlePeripheral.enableHapticsChar = hapticsEnableCharacteristic
              peripheral.setNotifyValue(false, for: characteristic)
              peripheral.readValue(for: characteristic)
              print("Haptics Enable Characteristic: \(hapticsEnableCharacteristic.uuid)")
            }
            
            // Haptics Front Motor
            if characteristic.uuid.isEqual(hapticsFrontMotor_UUID){
                hapticsFrontMotorCharacteristic = characteristic
              BlePeripheral.hapticsFrontMotorChar = hapticsFrontMotorCharacteristic
              peripheral.setNotifyValue(false, for: characteristic)
              peripheral.readValue(for: characteristic)
              print("Front Motor Characteristic: \(hapticsFrontMotorCharacteristic.uuid)")
            }
            
            // Haptics Middle Motor
            if characteristic.uuid.isEqual(hapticsMiddleMotor_UUID){
                hapticsMiddleMotorCharacteristic = characteristic
              BlePeripheral.hapticsMiddleMotorChar = hapticsMiddleMotorCharacteristic
              peripheral.setNotifyValue(false, for: characteristic)
              peripheral.readValue(for: characteristic)
              print("Middle Motor Characteristic: \(hapticsMiddleMotorCharacteristic.uuid)")
            }
            
            // Haptics Back Motor
            if characteristic.uuid.isEqual(hapticsBackMotor_UUID){
                hapticsBackMotorCharacteristic = characteristic
              BlePeripheral.hapticsBackMotorChar = hapticsBackMotorCharacteristic
              peripheral.setNotifyValue(false, for: characteristic)
              peripheral.readValue(for: characteristic)
              print("Back Motor Characteristic: \(hapticsBackMotorCharacteristic.uuid)")
            }
            
        }

//        peripheral.setNotifyValue(true, for: characteristics.last!)
//        peripheral.readValue(for: characteristics.last!)
        
        print("charac: ", characteristics)
        print("battery:::", batteryCharacteristic.uuid)
    }
    
    //ㅗㅗㅗㅗㅗ
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        
        if characteristic == batteryCharacteristic {
            let characteristicValue = characteristic.value
            let ASCIIstring = String(data: characteristic.value!, encoding: String.Encoding.ascii)
            let characteristicASCIIValue = ASCIIstring
            batteryLife = ASCIIstring! as String
//            batteryLifeInt = Character("\(batteryLife)").asciiValue!

            print("Battery Value Recieved: \((characteristicASCIIValue! as String))")
            print("Battery Int: \(batteryLifeInt)")

            NotificationCenter.default.post(name:NSNotification.Name(rawValue: "Notify"), object: "\((characteristicASCIIValue! as String))")
        }
        
//        if characteristic == readCharacteristic {
//            guard let characteristicValue = characteristic.value,
//                  let ASCIIstring = String(data: characteristicValue, encoding: String.Encoding.ascii) else {return}
////            let characteristicValue = characteristic.value
////            let ASCIIstring = String(data: characteristic.value!, encoding: String.Encoding.ascii)
//            let characteristicASCIIValue = ASCIIstring
//
//            print("Value Recieved: \((characteristicASCIIValue as String))")
//
//            NotificationCenter.default.post(name:NSNotification.Name(rawValue: "Notify"), object: "\((characteristicASCIIValue as String))")
//        }
//
//        if characteristic == writeCharacteristic {
//            let characteristicValue = characteristic.value
//            let ASCIIstring = String(data: characteristic.value!, encoding: String.Encoding.ascii)
//            let characteristicASCIIValue = ASCIIstring
//
//            print("Value Sent: \((characteristicASCIIValue! as String))")
//
//            NotificationCenter.default.post(name:NSNotification.Name(rawValue: "Notify"), object: "\((characteristicASCIIValue! as String))")
//        }
        
//        if characteristic == tensStimCharacteristic {
//            let characteristicValue = characteristic.value
//            let ASCIIstring = UInt8(data: characteristic.value!, encoding: String.Encoding.ascii)
//            let characteristicASCIIValue = ASCIIstring
//            stimulation = ASCIIstring!
////            batteryLifeInt = Character("\(batteryLife)").asciiValue!
//
//            print("Battery Value Recieved: \((characteristicASCIIValue! as String))")
////            print("Battery Int: \(batteryLifeInt)")
//
//            NotificationCenter.default.post(name:NSNotification.Name(rawValue: "Notify"), object: "\((characteristicASCIIValue! as String))")
//        }
        
        
    }
    
    
    // Original didUpdateValueFor Function
    
//    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
//
//        var characteristicASCIIValue = NSString()
//        print("current char: ", characteristic)
//
//        guard characteristic == batteryCharacteristic,
//
//          let characteristicValue = characteristic.value,
//          let ASCIIstring = NSString(data: characteristicValue, encoding: String.Encoding.utf8.rawValue) else { return }
//
//          characteristicASCIIValue = ASCIIstring
//
//            batteryLife = ASCIIstring as String
//            if batteryLife != nil {
//                batteryLifeInt = Character("\(batteryLife)").asciiValue!
//            } else {
//                batteryLifeInt = 0;
//            }
//
//        print("Battery Value Recieved: \((characteristicASCIIValue as String))")
//        print("Battery Int: \(batteryLifeInt)")
//
//        NotificationCenter.default.post(name:NSNotification.Name(rawValue: "Notify"), object: "\((characteristicASCIIValue as String))")
//
////        if characteristic.uuid == CBUUID(string: "6E400003-B5A3-F393-E0A9-E50E24DCCA9E") {
////            print("Works!!!")
////        }
//
//        guard characteristic.uuid == UARTReadCharacteristic_UUID,
//
//              let characteristicValue = characteristic.value,
//              let ASCIIstring = NSString(data: characteristicValue, encoding: String.Encoding.utf8.rawValue) else { return }
//
//          characteristicASCIIValue = ASCIIstring
//
//        print("Value Recieved From Controller: \((characteristicASCIIValue as String))")
//
//        NotificationCenter.default.post(name:NSNotification.Name(rawValue: "Notify"), object: "\((characteristicASCIIValue as String))")
//
//
//        guard characteristic == writeCharacteristic,
//
//              let characteristicValue = characteristic.value,
//              let ASCIIstring = NSString(data: characteristicValue, encoding: String.Encoding.utf8.rawValue) else { return }
//
//          characteristicASCIIValue = ASCIIstring
//
//        print("Value Sent From App: \((characteristicASCIIValue as String))")
//
////        NotificationCenter.default.post(name:NSNotification.Name(rawValue: "Notify"), object: "\((characteristicASCIIValue as String))")
//
////        var characteristicASCIIValue = NSString()
////        guard characteristic == rxCharacteristic,
////
////        guard let characteristicValue = characteristic.value,
////              let ASCIIString = NSString(data: characteristicValue, encoding: String.Encoding.utf8.rawValue) else {return}
////        print("value: ", characteristicValue)
////
////        batteryLife = ASCIIString as String
////        if batteryLife != nil {
////            batteryLifeInt = Character("\(batteryLife)").asciiValue!
////        } else {
////            batteryLifeInt = 0;
////        }
//
//        print("value: 00000")
//        print("value: ", batteryLifeInt)
//    }
        
    
    func disconnectFromDevice() -> Void {
        if myPeripheral != nil {
            myCentral.cancelPeripheralConnection(myPeripheral)
        }
        print("battery:::", batteryCharacteristic)
    }
    
    @Published var sensors: [RTSensor] = []

}
