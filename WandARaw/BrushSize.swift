//
//  BrushSize.swift
//  WandARaw
//
//  Created by Sena Kristiawan on 29/04/24.
//

import SwiftUI

struct BrushSize: View {
    var body: some View {
        Button(action: {
            /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
        }){
            Image(systemName: "paintbrush.pointed.fill")
                .resizable()
                .scaledToFit()
        }
    }
}

#Preview {
    BrushSize()
}
