//
//  GUUIDGenApp.swift
//  GUUIDGen
//
//  Created by Andrew Satori on 11/9/21.
//

import SwiftUI
import AppKit

class AppDelegate: NSResponder, NSApplicationDelegate {
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true;
    }
}

@main
struct GUUIDGenApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
