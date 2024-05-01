//
//  DrawingService.swift
//  WandARaw
//
//  Created by Sherly Phangestu on 29/04/24.
//

import SceneKit
import ARKit

class DrawingService: NSObject{
    let sceneView = ARManager.shared.sceneView
    var groupNodes: [SCNNode] = []
    
    func makeNewParentNode() {
        let node = SCNNode()
        sceneView.scene.rootNode.addChildNode(node)
    }
    
    func addChildNode(node: SCNNode){
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
        sceneView.scene.rootNode.childNodes.last?.addChildNode(node)
    }
    
    func lastAddedNode() -> SCNNode? {
        guard let lastNode = sceneView.scene.rootNode.childNodes.last else {
            return nil
        }
        
        return lastNode
    }
    
    func undoLastNode(){
        lastAddedNode()?.removeFromParentNode()
    }
    
    func deleteAllNode(){
        sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
        }
        groupNodes.removeAll()
    }

}

