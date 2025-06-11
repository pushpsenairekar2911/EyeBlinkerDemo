//
//  CameraPermissionManager.swift
//  EyeTracker
//
//  Created by Pushpsen Airekar on 10/06/25.
//


import AVFoundation

final class CameraPermissionManager {
    static let shared = CameraPermissionManager()

    private init() {}

    func requestCameraAccessIfNeeded() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            print("✅ Camera access already granted.")
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    if granted {
                        print("✅ Camera access granted.")
                    } else {
                        print("❌ Camera access denied.")
                    }
                }
            }
        case .denied, .restricted:
            print("❌ Camera access previously denied or restricted.")
        @unknown default:
            print("⚠️ Unknown camera access status.")
        }
    }
}
