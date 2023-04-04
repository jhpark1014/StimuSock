//
//  RTSensors.swift
//  StimuSock
//
//  Created by Sarah Park on 2/4/23.
//

import Foundation
import CoreBluetooth

enum RTSensorType {
    case adafruit
}

struct RTSensor {
    let peripheral: CBPeripheral
    let name: String
    let type: RTSensorType
    var isConnected: Bool
}
