//
//  HomePage.swift
//  StimuSock
//
//  Created by Sarah Park on 1/28/23.
//

import SwiftUI

struct HomePage: View {
    var body: some View {
        NavigationView {
            VStack{
                Text("StimuSock")
                Image("SockIcon")
                Button("Start") {
                    // Turn on/off device
                }
                .padding()
                HStack{
                    Text("TENS")
                        .padding()
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
                .navigationTitle("Stimusock")
                .toolbar {
                    ToolbarItemGroup(placement: .bottomBar){
                        Button(action: {}, label: {Image("HomeIcon")})
                        Button("Device Stat")
                        {
                            print("Device Stat")
                        }
                    }
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
