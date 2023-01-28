//
//  ContentView.swift
//  StimuSock
//
//  Created by Sarah Park on 1/28/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image("SockIcon")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("StimuSock")
                NavigationLink(destination: HomePage()) {
                    Text("Start")
                    
                }
            }
            .padding()
            .bold()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
