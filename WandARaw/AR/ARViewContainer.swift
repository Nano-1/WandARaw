//
//  ARViewContainer.swift
//  WandARaw
//
//  Created by Sherly Phangestu on 29/04/24.
//

import SwiftUI

struct ARViewContainer: UIViewControllerRepresentable {
    @Binding var isBrushPressing: Bool
    let viewController : ViewController
    
    func makeUIViewController(context: Context) -> ViewController {
//        let viewController = ViewController()
        viewController.isBrushPressing = isBrushPressing
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        // Update the view controller configuration if needed
        uiViewController.isBrushPressing = isBrushPressing
    }
}
