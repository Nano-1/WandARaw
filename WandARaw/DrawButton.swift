//
//  DrawButton.swift
//  WandARaw
//
//  Created by Sena Kristiawan on 29/04/24.
//

import SwiftUI

struct DrawButton: View {
    
    var body: some View {
        Image(systemName: "paintbrush.pointed.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 48, height: 48)
    }
}

#Preview {
    DrawButton()
}
