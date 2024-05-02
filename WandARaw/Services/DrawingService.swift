//
//  DrawingService.swift
//  WandARaw
//
//  Created by Sherly Phangestu on 29/04/24.
//

import SceneKit
import ARKit
//import CoreMotion

class DrawingService: NSObject, SCNPhysicsContactDelegate {
    let sceneView = ARManager.shared.sceneView
    var groupNodes: [SCNNode] = []
    let cubeNode = SCNNode(geometry:SCNBox(width: 0.2, height: 0.2, length: 1, chamferRadius: 0.3))
    let circleNode = SCNNode(geometry:SCNPlane(width: 0.6, height: 0.6))
//    let motionManager = CMMotionManager()

//    override init() {
//        super.init()
//        sceneView.scene.physicsWorld.contactDelegate = self
//    }
//    
//    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
//        // Check if the contact is between the cubeNode and another node
//        if contact.nodeA == cubeNode || contact.nodeB == cubeNode {
//            // Update the position of cubeNode
//            let newPosition = SCNVector3(
//                x: Float.random(in: -1...1),
//                y: Float.random(in: -1...1),
//                z: Float.random(in: -1...1)
//            )
//            cubeNode.position = newPosition
//        }
//    }
    
    
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
    
    func applyPhysicsToNode() {
//        guard let accelerometerData = motionManager.accelerometerData else { return }

        lastAddedNode()?.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        lastAddedNode()?.physicsBody?.isAffectedByGravity = false
        
        // Add a physics body to the cube node
        cubeNode.position = SCNVector3(0, 0, -1)
        cubeNode.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(geometry: SCNBox(width: 0.2, height: 0.2, length: 1, chamferRadius: 0), options: nil))
        cubeNode.physicsBody?.isAffectedByGravity = false
        
        circleNode.position = SCNVector3(0, 0, -1.1)
        circleNode.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(geometry: SCNPlane(width: 0.6, height: 0.6), options: nil))
        circleNode.physicsBody?.isAffectedByGravity = false

        // Set up collision detection
        lastAddedNode()?.physicsBody?.categoryBitMask = 1
        cubeNode.physicsBody?.categoryBitMask = 2
        lastAddedNode()?.physicsBody?.collisionBitMask = 2
        cubeNode.physicsBody?.collisionBitMask = 1
        cubeNode.physicsBody?.contactTestBitMask = 2
        

//        let forceDirection = SCNVector3(Float(accelerometerData.acceleration.x),
//                                             Float(accelerometerData.acceleration.y),
//                                             Float(accelerometerData.acceleration.z))
        let force = SCNVector3(0, 0, -1) // Apply force along the negative z-axis
        lastAddedNode()?.physicsBody?.applyForce(force, asImpulse: true)
//        cubeNode.physicsBody?.applyForce(force, asImpulse: true)
//        let newPosition = SCNVector3(
//            x: 0,
//            y: 0,
//            z: cubeNode.position.z - Float.random(in: 0...1)
//        )
//        cubeNode.position = newPosition
        
        
//        // Apply an impulse to the parent node to make it wiggle back and forth
//        let impulse = SCNVector3(0.1, 0, 0) // Apply impulse along the x-axis
//        lastAddedNode()?.physicsBody?.applyForce(impulse, asImpulse: true)
    }
    
    func createCube() -> SCNNode {
        let cube = SCNBox(width: 0.2, height: 0.3, length: 0.2, chamferRadius: 0)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.white
        cube.materials = [material]
        let cubeNode = SCNNode(geometry: cube)
        cubeNode.position = SCNVector3(0, 0, 0) // Adjust position as needed
        return cubeNode
    }

}

