//
//  ARPortalContainer.swift
//  WandARaw
//
//  Created by Sherly Phangestu on 30/04/24.
//

import SwiftUI

struct ARPortalContainer: UIViewControllerRepresentable {
    @Binding var isBrushPressing: Bool
    
    func makeUIViewController(context: Context) -> PortalController {
        let portalController = PortalController()
        portalController.isBrushPressing = isBrushPressing
        return portalController
    }
    
    func updateUIViewController(_ uiViewController: PortalController, context: Context) {
        // Update the view controller configuration if needed
    }
}
