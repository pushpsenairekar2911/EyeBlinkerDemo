//
//  EyeTrackerApp.swift
//  EyeTracker
//
//  Created by Pushpsen Airekar on 10/06/25.
//

import SwiftUI
import AVFoundation

@main
struct EyeTrackerApp: App {
    
    init() {
        CameraPermissionManager.shared.requestCameraAccessIfNeeded()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
