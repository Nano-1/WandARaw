//
//  Pallete.swift
//  WandARaw
//
//  Created by Sena Kristiawan on 01/05/24.
//

import SwiftUI

struct Pallete: View {
    var body: some View {
        Image(systemName: "paintpalette.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 35)
    }
}

#Preview {
    Pallete()
}
