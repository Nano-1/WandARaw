//
//  ViewController.swift
//  WandARaw
//
//  Created by Sherly Phangestu on 29/04/24.
//

import UIKit
import SceneKit
import ARKit
import SwiftUI


class ViewController: UIViewController, ARSCNViewDelegate, SCNPhysicsContactDelegate {

    @IBOutlet var sceneView: ARSCNView!
    let drawingService = DrawingService()
    
    var isBrushPressing: Bool = false {
        didSet {
            // Use isBrushPressing in your AR scene
            print("isBrushPressing: \(isBrushPressing)")
            
            if isBrushPressing {
                drawingService.makeNewParentNode()
            } else {
                drawingService.applyPhysicsToNode()
            }
        }
    }

    var selectedColor : Color = .blue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if drawingService.motionManager.isAccelerometerAvailable {
//            drawingService.motionManager.accelerometerUpdateInterval = 0.01
//            drawingService.motionManager.startAccelerometerUpdates()
//           } else {
//               print("Accelerometer data is not available")
//           }
//        
        sceneView = ARManager.shared.sceneView
        sceneView.frame = self.view.frame
        self.view.addSubview(sceneView)
        
        // Set the view's delegate
        sceneView.delegate = self
        
        sceneView.autoenablesDefaultLighting = true
        
        let mainScene = SCNScene()
//        let cubeNode = createCube()
        mainScene.rootNode.addChildNode(drawingService.cubeNode)
//        mainScene.rootNode.addChildNode(drawingService.circleNode)
        sceneView.scene = mainScene
        
        sceneView.scene.physicsWorld.contactDelegate = self
    }
    
        func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
            // Check if the contact is between the cubeNode and another node
            if contact.nodeA == drawingService.cubeNode || contact.nodeB == drawingService.cubeNode {
                print("masuk")
                // Update the position of cubeNode
                let newPosition = SCNVector3(
                    x: Float.random(in: -1...0),
                    y: Float.random(in: -1...0),
                    z: Float.random(in: -1...0)
                )
                drawingService.cubeNode.position = newPosition
            }
        }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
    func renderer(_ renderer: any SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
        
        let constants = Constants()
        
        let sphere = SCNNode()
        sphere.name = constants.sphereName
        sphere.geometry = SCNSphere(radius:0.01)
//        print("selected color is \(selectedColor)")
        sphere.geometry?.firstMaterial?.diffuse.contents = UIColor(selectedColor)
        
        if isBrushPressing {
            drawingService.addChildNode(node: sphere)
        }
    }
}
