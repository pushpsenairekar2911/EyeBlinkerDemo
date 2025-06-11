//
//  EyeTrackerManager.swift
//  EyeTracker
//
//  Created by Pushpsen Airekar on 10/06/25.
//

import Foundation

protocol EyeTrackerDelegate: AnyObject {
    func didUpdateBlinkCount(_ count: Int)
}

final class EyeTrackerManager {
    private var process: Process?
    private var pipe: Pipe?
    weak var delegate: EyeTrackerDelegate?
    
    func startTracking() {
        let process = Process()
        let pipe = Pipe()
        
        
        if let resourcePath = Bundle.main.resourcePath {
            let contents = try? FileManager.default.contentsOfDirectory(atPath: resourcePath)
            print("📦 Bundle contents:", contents ?? [])
        }
        
        // Get Python script path from bundle
        guard let scriptPath = Bundle.main.path(forResource: "eye_blink_counter", ofType: "py") else {
            print("❌ Script not found in bundle.")
            return
        }
        
        process.executableURL = URL(fileURLWithPath: "/usr/bin/python3")
        process.arguments = [scriptPath, "--json_output"]
        process.standardOutput = pipe
        
        pipe.fileHandleForReading.readabilityHandler = { handle in
            let rawData = handle.availableData
            
            guard !rawData.isEmpty,
                  let outputString = String(data: rawData, encoding: .utf8) else {
                return
            }
            
            outputString
                .components(separatedBy: "\n")
                .forEach { line in
                    guard let lineData = line.data(using: .utf8),
                          let json = try? JSONSerialization.jsonObject(with: lineData) as? [String: Any],
                          let blinks = json["blink_count"] as? Int else {
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self.delegate?.didUpdateBlinkCount(blinks)
                    }
                }
        }
        
        do {
            try process.run()
            self.process = process
            self.pipe = pipe
        } catch {
            print("❌ Failed to run Python script:", error)
        }
    }
    
    func stopTracking() {
        process?.terminate()
        pipe?.fileHandleForReading.readabilityHandler = nil
        process = nil
        pipe = nil
    }
}
