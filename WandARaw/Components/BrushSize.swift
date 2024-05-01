//
//  BrushSize.swift
//  WandARaw
//
//  Created by Sena Kristiawan on 30/04/24.
//

import SwiftUI

struct BrushSize: View {
    var body: some View {
        Image(systemName: "paintbrush.pointed")
            .resizable()
            .scaledToFit()
            .frame(width: 35)
    }
}

#Preview {
    BrushSize()
}
