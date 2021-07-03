//
//  JabsApp.swift
//  Jabs
//
//  Created by Ryan The on 2/7/21.
//

import SwiftUI

@main
struct JabsApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                EmptyView()
            }
            .hidden()
        }
    }
}
