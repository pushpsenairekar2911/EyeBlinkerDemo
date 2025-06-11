//
//  ContentView.swift
//  EyeTracker
//
//  Created by Pushpsen Airekar on 10/06/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()

    var body: some View {
        VStack(spacing: 20) {
            
            Image("wellness-at-ai-logo")
                .resizable()
                .frame(width: 100, height: 100)
            
            Divider()
            
            Text("Blink Count: \(viewModel.blinkCount)")
                .font(.largeTitle)
                .foregroundStyle(.black)

            HStack {
                GlossyButton(title: "Start Tracking") {
                    viewModel.startTracking()
                }
                .keyboardShortcut("s")

                GlossyButton(title: "Stop Tracking") {
                    viewModel.stopTracking()
                }
                .keyboardShortcut("x")
            }
        }
        .padding()
        .background(Color.white)
    }
}

#Preview {
    ContentView()
}

