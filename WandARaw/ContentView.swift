//
//  ContentView.swift
//  WandARaw
//
//  Created by Glenn Leonali on 29/04/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isPhotoTapped = false
    let imageSaver = ImageSaver()
    let viewController = ViewController()
    
    var body: some View {
        ZStack{
            ARViewContainer()
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center) {
                Spacer()
                Text("+")
                Spacer()
                
                Button(action: {
                    print("we did it")
                    isPhotoTapped = true
                    imageSaver.writeToPhotoAlbum(image: viewController.sceneView.snapshot())
                }, label: {
                    Image(systemName: "camera.fill")
                        .resizable()
                        .frame(width: 50, height: 35)
                        .scaledToFit()
                })
                
            }
            
            Rectangle()
                .fill(Color.white)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-100, alignment: .center)
                .foregroundStyle(Color.white)
                .opacity(isPhotoTapped ? 1.0 : 0.0)
                .animation(.easeInOut(duration: 0.3))
                .onAppear {
                    // Reset the flag after animation completes
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        isPhotoTapped = false
                    }
                }
            
        }
    }
    
    func photoButton() {
        
    }
    
    func takePhoto() {
        
    }
    
}

#Preview {
    ContentView()
}
