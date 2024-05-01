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
    let arViewController = ViewController()
    @State private var isPhotoTapped = false
    @State var selectedColor = Color.blue
    @State private var isBrushPressing = false
    
    var body: some View {
        ZStack(content: {
            ARViewContainer(isBrushPressing: $isBrushPressing, viewController: arViewController)
                .edgesIgnoringSafeArea(.all)
            // Add button here
//            Rectangle().fill(.blue)
            
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
                    IconButton(imageName: "arrow-uturn-left", iconSize: 25, buttonFill: false, label: "color") {
                        print("Undo tapped") // Handle button tap action
                        drawingService.undoLastNode()
                    }
                }
                Spacer()
                HStack(alignment: .center, spacing: 40) {
//                  Tools Icon
                    AnimateBrushColor(selectedColor: $selectedColor, contentViewInstance: self, viewController: arViewController)
//                    {
//                        print("Tools tapped") // Handle button tap action
//                    }
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
