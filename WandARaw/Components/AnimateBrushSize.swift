//
//  AnimateBrushSize.swift
//  WandARaw
//
//  Created by Sena Kristiawan on 30/04/24.
//

import SwiftUI

struct AnimateBrushSize: View {
    @Binding var brushSize : Double
    var viewController : ViewController
    var contentView: ContentView
    @State private var isBrushSizeVisible = false
    var body: some View {
        VStack{
            if isBrushSizeVisible{
                sizeListView
            }
                BrushSize()
                    .onTapGesture {
                        withAnimation(.easeInOut){
                            isBrushSizeVisible.toggle()
                        }
                    }
                    .padding()
        }
    }
    @ViewBuilder
    var sizeListView: some View{
        Slider(
            value: $brushSize,
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
        .onChange(of: brushSize){
            viewController.selectedSize = self.brushSize
            contentView.selectedSize = self.brushSize
        }
        .frame(width: 250, height: 20)
        .bold()

    }
}
