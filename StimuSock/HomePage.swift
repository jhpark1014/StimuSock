//
//  HomePage.swift
//  StimuSock
//
//  Created by Sarah Park on 1/28/23.
//

import SwiftUI

struct HomePage: View {
    @State var buttonCounter = 1
    @State var buttonString = Text("Start")
    var body: some View {
//        NavigationView {
        VStack{
            Text("StimuSock")
            Image("SockIcon")
            Button("\(buttonString)") {
                // Turn on/off device
                buttonSwitch()
                print(buttonCounter)
            }
            .padding()
            HStack{
                Text("TENS")
//                        .padding()
                Button("-") {
                    // Decrease TENS
                }
                // Get mA from bluetooth and display
                Button("+") {
                    // Increase TENS
                }
            }
            HStack{
                Text("Haptics")
                    .padding()
                Button("-") {
                    // Decrease TENS
                }
                // Get frequency from bluetooth and display
                Button("+") {
                    // Increase TENS
                }
            }
//                .navigationTitle("Home")
//                .toolbar {
//                    ToolbarItemGroup(placement: .bottomBar){
                    NavigationLink(destination: Device_Stat()) {
                        Text("Device Stat")
                    }
//                        .frame(height: .infinity, alignment: .bottom)
                }
//                }
//            }
//        }
    }
    
    func buttonSwitch() {
//        buttonCounter += 1
        print(Text("여기"), buttonCounter)
        switch buttonCounter {
        case 1:
            buttonString = Text("Stop")
            buttonCounter += 1
            break
            
        case 2:
            buttonString = Text("Start")
            buttonCounter -= 1
            break
            
        default: Text("Hi")
        }
//        print(buttonCounter)
    }
}



struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
