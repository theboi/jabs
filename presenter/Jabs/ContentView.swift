//
//  ContentView.swift
//  Jabs
//
//  Created by Ryan The on 2/7/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var screenshot: CGImage?
    @State private var name: String = ""
    @State private var isConnected: Bool = false

    var body: some View {
        VStack {
            if let screenshot = screenshot {
                Image(screenshot, scale: 10, label: Text("Hi")).scaledToFit()
            }
            Button("Screenshot") {
                takeScreenshot()
            }
            TextField("Name", text: $name).padding().disabled(isConnected)
            HStack {
                Button(isConnected ? "Disconnect" : "Connect") {
                    connectToWebsocket()
                }
                Image(systemName: "circle.fill")
                                .imageScale(.small)
                                .foregroundColor(isConnected ? .green : .red)
            }
        }.frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .center
        )
    }
    
    private func connectToWebsocket() {
        isConnected = !isConnected
    }
    
    private func takeScreenshot() {
        let windowInfoList = CGWindowListCopyWindowInfo(.optionAll, kCGNullWindowID)!
            as NSArray
        
        let apps = NSRunningApplication.runningApplications(withBundleIdentifier:
            /* Bundle ID of the application, e.g.: */ "com.apple.Safari")
        if apps.isEmpty {
            // Application is not currently running
            print("The application is not running")
            return // Or whatever
        }
        let appPID = apps[0].processIdentifier
        
        var appWindowsInfoList = [NSDictionary]()
        for info_ in windowInfoList {
            let info = info_ as! NSDictionary
            if (info[kCGWindowOwnerPID as NSString] as! NSNumber).intValue == appPID {
                appWindowsInfoList.append(info)
            }
        }
        
        let appWindowInfo: NSDictionary = appWindowsInfoList[0];
        let windowID: CGWindowID = (appWindowInfo[kCGWindowNumber as NSString] as! NSNumber).uint32Value
        
        let windowImage: CGImage? =
            CGWindowListCreateImage(.infinite, .optionAll, windowID,
                                    [.boundsIgnoreFraming, .bestResolution])
        
        screenshot = windowImage
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
