//
//  ContentViewModel.swift
//  EyeTracker
//
//  Created by Pushpsen Airekar on 10/06/25.
//


import Foundation

final class ContentViewModel: ObservableObject {
    
    @Published var blinkCount: Int = 0
    
    private let eyeTracker = EyeTrackerManager()
    
    init() {
        eyeTracker.delegate = self
    }
    
    func startTracking() {
        eyeTracker.startTracking()
    }
    
    func stopTracking() {
        eyeTracker.stopTracking()
    }
}

extension ContentViewModel: EyeTrackerDelegate {
    func didUpdateBlinkCount(_ count: Int) {
        blinkCount = count
    }
}
