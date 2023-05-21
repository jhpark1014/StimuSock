//
//  PopUpView.swift
//  StimuSock
//
//  Created by Sarah Park on 4/7/23.
//

import SwiftUI

struct PopUpView: View {
    @Binding var show: Bool
    @EnvironmentObject var bleController: BLEController
    
    var body: some View {
        ZStack {
            if show {
                VStack {
                    if bleController.connectionSuccess {
                        Text("Successfully connected to StimuSock")
                    } else {
                        Text("Connection failed. Please try again.")
                    }
                    
                    Button("OK") {
                        withAnimation(.linear(duration: 0.3)) {
                            show = false
                        }
                    }
                }
                .frame(maxWidth: 300)
                .border(Color.black, width: 2)
            }
        }
    }
}

//struct PopUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        PopUpView()
//    }
//}
