//
//  Toolbar.swift
//  StimuSock
//
//  Created by Sarah Park on 1/28/23.
//

import SwiftUI

struct Toolbar: View {
    var body: some View {
        TabView {
            HomePage()
                .tabItem() {
                    Image("HomeIcon")
                    Text("Home")
                }
            Device_Stat()
                .tabItem() {
                    Image("SockIcon")
                    Text("Device Stat")
                }
        }
    }
}

struct Toolbar_Previews: PreviewProvider {
    static var previews: some View {
        Toolbar()
    }
}
