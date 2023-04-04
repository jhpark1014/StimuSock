//
//  BlePeripheral.swift
//  StimuSock
//
//  Created by Sarah Park on 2/14/23.
//

import Foundation
import CoreBluetooth

class BlePeripheral {
    static var connectedPeripheral: CBPeripheral?
    static var connectedService: CBService?
    static var connectedReadChar: CBCharacteristic?
    static var connectedWriteChar: CBCharacteristic?
    static var connectedBatteryChar: CBCharacteristic?
    // TENS
    static var enableTENSChar: CBCharacteristic?
    static var tensStimChar: CBCharacteristic?
    // Haptics
    static var enableHapticsChar: CBCharacteristic?
    static var hapticsFrontMotorChar: CBCharacteristic?
    static var hapticsMiddleMotorChar: CBCharacteristic?
    static var hapticsBackMotorChar: CBCharacteristic?
}
