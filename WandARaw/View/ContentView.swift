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
    let secretCode: [Color] = [.red, .yellow, .black, .blue]
    
    @State var isOpen: Bool = false
    @State private var isPhotoTapped = false
    @State private var isPalleteVisible = false
    @State var selectedColor = Color.blue
    @State var colorFormationArr: [Color] = []
    @State var selectedSize = 0.0025
    @State private var isBrushPressing = false
    @State var count = 0
    @State private var isShowingSplash = true
    
    var body: some View {
        ZStack(content: {
            ARViewContainer(isBrushPressing: $isBrushPressing, viewController: arViewController)
                .edgesIgnoringSafeArea(.all)
            // Add button here
            //            Rectangle().fill(.blue)
            
            // Crosshair
            Image("plus")
            
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
                if isPalleteVisible {
                    paletteView
                }
                HStack(alignment: .center, spacing: 40) {
                    
//------------------Color Icon
                    Image(systemName: "paintpalette.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35)
                        .onTapGesture {
                            withAnimation(.easeInOut){
                                isPalleteVisible.toggle()
                            }
                        }
                        .padding()
                        .foregroundStyle(Color(selectedColor))
                    
//------------------Brush Icon
                    IconButton(imageName: "brush", iconSize: 35, buttonFill: true, label: "brush") {
                        print("Brush tapped") // Handle button tap action
                    }
                    .onLongPressGesture(minimumDuration: 0.1,
                                        maximumDistance: .infinity,
                                        pressing: { isPressing in
                        self.isBrushPressing = isPressing
                        
                    }, perform: {})
                    .padding()
                    //                  Camera Icon
                    IconButton(imageName: "camera", iconSize: 35, buttonFill: false, label: "camera") {
                        print("Camera tapped") // Handle button tap action
                        takePhoto()
                    }
                }
//                .padding(16)
            }
            // Photo Taken Indicator
            Rectangle()
                .fill(.white)
                .ignoresSafeArea()
                .opacity(isPhotoTapped ? 1.0 : 0.0)
                .animation(.easeInOut(duration: 0.3), value: isPhotoTapped)
            
            // Splash screen
            if isShowingSplash {
                SplashScreenView()
                    .onAppear {
                        // Simulate a deslay to show the splash screen for a few seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                isShowingSplash = false
                            }
                        }
                    }
            }
        })
    
    }
    @ViewBuilder
    var paletteView: some View {
        ZStack {
            HStack {
                AnimateBrushColor(selectedColor: $selectedColor, contentViewInstance: self, viewController: arViewController, colorFormationArr: $colorFormationArr, count: $count)
                    .buttonStyle(.plain)
                .padding(16)
                .offset(x: 20)
                Spacer()
            }
            HStack {
                Spacer()
                Slider(
                    value: $selectedSize,
                    in: 0.0005...0.01,
                    step: 0.000025
                )
                {
                    Text("Size")
                } minimumValueLabel:{
                    Text("0")
                        .bold()
                } maximumValueLabel: {
                    Text("100")
                        .bold()
                }
                .onChange(of: selectedSize){
                    arViewController.selectedSize = selectedSize
                }
                .frame(width: 250, height: 20)
                .bold()
                .rotationEffect(Angle(degrees: -90))
                .offset(x: 80)
            }
        }
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
