//
//  Bluetooth Connection.swift
//  StimuSock
//
//  Created by Kelly Xu on 2/3/23.
// Youtube Tutorial: Core Bluetooth in Swift by AF Swift Tutorials

import SwiftUI
import CoreBluetooth
class BluetoothViewModel: NSObject, ObservableObject{
    private var centralManager: CBCentralManager?
    private var peripherals:[CBPeripheral]=[]
    @Published var peripheralNames: [String]=[]
    
    override init(){
        super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: .main)
    }
}

//used to get peripherals
extension BluetoothViewModel: CBCentralManagerDelegate{
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn{
            self.centralManager?.scanForPeripherals(withServices: nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if !peripherals.contains(peripheral){
            self.peripherals.append(peripheral)
            self.peripheralNames.append(peripheral.name ?? "Unnamed Device")
        }
    }
}

struct BluetoothConnection: View {
    @ObservedObject private var bluetoothViewModel = BluetoothViewModel()
    var body: some View {
        NavigationView{
            List(bluetoothViewModel.peripheralNames, id: \.self){ peripheral in
                Text(peripheral)
            }
            .navigationTitle("Peripherals")
        }
    }
}

struct BluetoothConnection_Previews: PreviewProvider {
    static var previews: some View {
        BluetoothConnection()
    }
}
