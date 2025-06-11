//
//  GlossyButton.swift
//  EyeTracker
//
//  Created by Pushpsen Airekar on 10/06/25.
//

import SwiftUI

struct GlossyButton: View {
    var title: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(.vertical, 12)
                .padding(.horizontal, 24)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.white.opacity(0.4),
                                    Color.blue.opacity(0.7),
                                    Color.blue
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ))
                            .shadow(color: .blue.opacity(0.2), radius: 8, x: 0, y: 5)

                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.white.opacity(0.4), lineWidth: 1)
                    }
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(LinearGradient(
                            gradient: Gradient(colors: [
                                Color.white.opacity(0.6),
                                Color.white.opacity(0.05)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        ))
                        .blendMode(.overlay)
                )
                .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .buttonStyle(PlainButtonStyle())
    }
}
