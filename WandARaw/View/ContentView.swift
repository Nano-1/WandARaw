//
//  ContentView.swift
//  WandARaw
//
//  Created by Sherly Phangestu on 29/04/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack(content: {
            ARViewContainer()
                .edgesIgnoringSafeArea(.all)
                // Add button here
        })
    }
}

#Preview {
    ContentView()
}
