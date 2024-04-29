//
//  ARViewContainer.swift
//  WandARaw
//
//  Created by Glenn Leonali on 29/04/24.
//

import SwiftUI

struct ARViewContainer: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ViewController {
        return ViewController()
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        // Update the view controller configuration if needed
    }
}
