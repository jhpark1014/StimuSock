//
//  Device Stat.swift
//  StimuSock
//
//  Created by Sarah Park on 1/28/23.
//

import SwiftUI

struct Device_Stat: View {
    var body: some View {
       
        VStack{
            Image("SockIcon")
            HStack{
                Text("First Connected")
                //add code for recording first connected data
            }
            HStack{
                Text("Last Connected")
                // add code for last connected data
            }
            HStack{
                Text("Total Hours Used")
                //add code for tracking hours
            }
            HStack{
                Text("Remaining Battery")
                //add code for remaining battery in percentages
            }
            //Button("Graph Stats") {
            //print("Navigate to Graph View")
    //    }
            //Button("Reset Stats History") {
            //print("Reset Stats History")
    //    }
            //Button("Disconnect Device") {
            //print("Disconnect Device")
    //    }
        }
//            .navigationBarBackButtonHidden(true)
    }
}

struct Device_Stat_Previews: PreviewProvider {
    static var previews: some View {
        Device_Stat()
    }
}
