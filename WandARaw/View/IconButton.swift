//
//  IconButton.swift
//  WandARaw
//
//  Created by Risa on 29/04/24.
//

import SwiftUI

struct IconButton: View {
    let imageName: String
    let iconSize: CGFloat
    let buttonFill: Bool
    let label: String
    var action: () -> Void
    
    @State private var isPressed = false

    var body: some View {
        Button(action: {
            self.action()
        }) {
        Circle()
            .fill(buttonFill == true ? .white : .clear)
            .overlay(Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: iconSize, height: iconSize)
            )
        .frame(width: 72, height: 72)
        .scaleEffect(isPressed ? 1.28 : 1.0)
        }
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    withAnimation {
                        self.isPressed = true
                    }
                }
                .onEnded { _ in
                    withAnimation {
                        self.isPressed = false
                    }
                }
        )
    }
}
