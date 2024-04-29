//
//  DrawingService.swift
//  WandARaw
//
//  Created by Sherly Phangestu on 29/04/24.
//

import SceneKit
import ARKit

class DrawingService: NSObject{
    static func addChildNode(node: SCNNode, sceneView: ARSCNView){
        guard let currentFrame = sceneView.session.currentFrame else {return}
        let camera = currentFrame.camera
        let transform = camera.transform
        var translationMatrix = matrix_identity_float4x4
        let cameraRelativePosition = SCNVector3(0,0,-0.1)
        translationMatrix.columns.3.x = cameraRelativePosition.x
        translationMatrix.columns.3.y = cameraRelativePosition.y
        translationMatrix.columns.3.z = cameraRelativePosition.z
        
        let modifiedMatrix = simd_mul(transform, translationMatrix)
        node.simdTransform = modifiedMatrix
        sceneView.scene.rootNode.addChildNode(node)
    }
}

