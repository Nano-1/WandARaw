//
//  ContentView.swift
//  WandARaw
//
//  Created by Sherly Phangestu on 29/04/24.
//

import SwiftUI

struct ContentView: View {
    
    let viewController = ARManager.shared
    @State private var isPhotoTapped = false
    
    var body: some View {
        ZStack(content: {
            ARViewContainer()
                .edgesIgnoringSafeArea(.all)
            
            // Crosshair
            Text("+")
                .fontWeight(.heavy)
                .foregroundStyle(Color.green)
            
            // Button
            VStack(alignment: .trailing) {
                Spacer()
                Button(action: {
                    takePhoto()
                }, label: {
                    Image(systemName: "camera.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50)
                        .padding()
                        .foregroundStyle(Color.black)
                })
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
