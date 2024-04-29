//
//  ARManager.swift
//  WandARaw
//
//  Created by Sherly Phangestu on 29/04/24.
//

import ARKit

class ARManager {
    static let shared = ARManager()
    
    private init() {
        sceneView = ARSCNView()
    }
    
    let sceneView: ARSCNView
}

