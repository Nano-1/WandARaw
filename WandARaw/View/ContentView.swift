//
//  ContentView.swift
//  WandARaw
//
//  Created by Sherly Phangestu on 29/04/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack(content: {
            ARViewContainer()
                .edgesIgnoringSafeArea(.all)
                // Add button here
            
            VStack {
                HStack {
//                  Trash Icon
                    IconButton(imageName: "trash", iconSize: 25, buttonFill: false, label: "trash") {
                        print("Trash tapped") // Handle button tap action
                    }
                    Spacer()
//                  Info Icon
                    IconButton(imageName: "trash", iconSize: 25, buttonFill: false, label: "trash2") {
                        print("Info tapped") // Handle button tap action
                    }
                }
                Spacer()
                HStack(alignment: .center, spacing: 40) {
//                  Color Icon
                    IconButton(imageName: "camera", iconSize: 35, buttonFill: false, label: "color") {
                        print("Color tapped") // Handle button tap action
                    }
//                  Brush Icon
                    IconButton(imageName: "brush", iconSize: 35, buttonFill: true, label: "brush") {
                        print("Brush tapped") // Handle button tap action
                    }
                    
//                  Camera Icon
                    IconButton(imageName: "camera", iconSize: 35, buttonFill: false, label: "camera") {
                        print("Camera tapped") // Handle button tap action
                    }
                }
                .padding(16)
            }
        })
    }
}

#Preview {
    ContentView()
}
