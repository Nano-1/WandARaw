//
//  ContentView.swift
//  WandARaw
//
//  Created by Sherly Phangestu on 29/04/24.
//

import SwiftUI

//protocol BrushPressingDelegate: AnyObject {
//    func setIsBrushPressing(_ isPressing: Bool)
//}

struct ContentView: View {
    @State private var isShowingSplash = true
    @State private var isBrushPressing = false
    
    var body: some View {
        ZStack(content: {
            ARViewContainer(isBrushPressing: $isBrushPressing)
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
                    .onLongPressGesture(minimumDuration: 0.1,
                                        maximumDistance: .infinity,
                                        pressing: { isPressing in
                        self.isBrushPressing = isPressing
                        print(isPressing)
                        print(self.isBrushPressing)
                                }, perform: {})
                                .padding()
                    
//                  Camera Icon
                    IconButton(imageName: "camera", iconSize: 35, buttonFill: false, label: "camera") {
                        print("Camera tapped") // Handle button tap action
                    }
                }
                .padding(16)
            }
            // Splash screen
            if isShowingSplash {
                SplashScreenView()
                    .onAppear {
                        // Simulate a delay to show the splash screen for a few seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                isShowingSplash = false
                            }
                        }
                    }
            }

        })
    }
}

#Preview {
    ContentView()
}
