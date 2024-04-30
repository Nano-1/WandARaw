//
//  ContentView.swift
//  WandARaw
//
//  Created by Sherly Phangestu on 29/04/24.
//

import SwiftUI

struct ContentView: View {
    
    let viewController = ARManager.shared
    let drawingService = DrawingService()
    @State private var isPhotoTapped = false
    
    @State private var isBrushPressing = false
    
    var body: some View {
        ZStack(content: {
            ARViewContainer(isBrushPressing: $isBrushPressing)
                .edgesIgnoringSafeArea(.all)
            // Add button here
            Rectangle().fill()
            
             // Crosshair
            Text("+")
                .fontWeight(.heavy)
                .foregroundStyle(Color.white)

            VStack {
                HStack {
//                  Trash Icon
                    IconButton(imageName: "trash", iconSize: 25, buttonFill: false, label: "trash") {
                        print("Trash tapped") // Handle button tap action
                        drawingService.deleteAllNode()
                    }
                    Spacer()
//                  Undo Icon
                    IconButton(imageName: "arrow.uturn.backward", iconSize: 25, buttonFill: false, label: "color") {
                        print("Color tapped") // Handle button tap action
                    }
                }
                Spacer()
                HStack(alignment: .center, spacing: 40) {
//                  Tools Icon
                    IconButton(imageName: "paintpalette", iconSize: 35, buttonFill: false, label: "brush") {
                        print("Brush tapped") // Handle button tap action
                    }
//                  Draw Icon
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
                    IconButton(imageName: "camera2", iconSize: 35, buttonFill: false, label: "camera") {
                        print("Camera tapped") // Handle button tap action
                        takePhoto()
                    }
                }
                .padding(16)
            }
            // Photo Taken Indicator
                Rectangle()
                    .fill(.white)
                    .ignoresSafeArea()
                    .opacity(isPhotoTapped ? 1.0 : 0.0)
                    .animation(.easeInOut(duration: 0.3), value: isPhotoTapped)
        })
    }

    func takePhoto() {
        isPhotoTapped = true
        UIImageWriteToSavedPhotosAlbum(viewController.sceneView.snapshot(), viewController, nil, nil)
        print("\(isPhotoTapped)")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            isPhotoTapped = false
        }
    }
    
}

#Preview {
    ContentView()
}
