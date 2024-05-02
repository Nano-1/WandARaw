//
//  PortalController.swift
//  WandARaw
//
//  Created by Sherly Phangestu on 30/04/24.
//

import UIKit
import SceneKit
import ARKit


class PortalController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    let portalService = PortalService()
    let cameraNode: SCNNode = SCNNode()
    var isBrushPressing: Bool = false {
        didSet {
            // Use isBrushPressing in your AR scene
            print("isBrushPressing: \(isBrushPressing)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView = ARManager.shared.portalSceneView
        sceneView.frame = self.view.frame
        self.view.addSubview(sceneView)
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Setup Camera
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 10) // Posisi awal kamera
        sceneView.scene.rootNode.addChildNode(cameraNode)
        
        addPortalToScene()
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
    
    func addPortalToScene(){
        createPortalWall()
    }
    
    func createPortalWall(){
        let parentNode = SCNNode()
        parentNode.position = SCNVector3(0, 0, -4)
        
        let wallLength = portalService.wallLength
        let wallHeight = portalService.wallHeight
        
        let rightWall = portalService.createVisibleInvisibleWall(isDoor: false)
        rightWall.position = SCNVector3(wallLength/2, 0, 0)
        
        let leftWall = portalService.createVisibleInvisibleWall(isDoor: false)
        leftWall.position = SCNVector3(-wallLength/2, 0, 0)
        leftWall.eulerAngles = SCNVector3(0, portalService.convertDegreeToRadiant(degree: 180), 0)
        
        let topWall = portalService.createVisibleInvisibleWall(isDoor: false, isTop: true)
        topWall.position = SCNVector3(0, wallHeight/2, 0)
        topWall.eulerAngles = SCNVector3(0, 0, portalService.convertDegreeToRadiant(degree: 90))
        
        let bottomWall = portalService.createVisibleInvisibleWall(isDoor: false, isBottom: true)
        bottomWall.position = SCNVector3(0, -wallHeight/2, 0)
        bottomWall.eulerAngles = SCNVector3(0, 0, portalService.convertDegreeToRadiant(degree: -90))
        
        let backWall = portalService.createVisibleInvisibleWall(isDoor: false)
        backWall.position = SCNVector3(0, 0, -wallLength/2)
        backWall.eulerAngles = SCNVector3(0, portalService.convertDegreeToRadiant(degree: 90), 0)
        
        let frontWallLeft = portalService.createVisibleInvisibleWall(isDoor: true)
        frontWallLeft.position = SCNVector3(-wallLength/2, 0, wallLength/2)
        frontWallLeft.eulerAngles = SCNVector3(0, portalService.convertDegreeToRadiant(degree: -90), 0)
        
        let frontWallRight = portalService.createVisibleInvisibleWall(isDoor: true)
        frontWallRight.position = SCNVector3(wallLength/2, 0, wallLength/2)
        frontWallRight.eulerAngles = SCNVector3(0, portalService.convertDegreeToRadiant(degree: -90), 0)
        
        let objectNode = portalService.addObjectDecoration()
        parentNode.addChildNode(objectNode)
        
        // Add wall node to parent node
        parentNode.addChildNode(rightWall)
        parentNode.addChildNode(leftWall)
        parentNode.addChildNode(topWall)
        parentNode.addChildNode(bottomWall)
        parentNode.addChildNode(backWall)
        parentNode.addChildNode(frontWallLeft)
        parentNode.addChildNode(frontWallRight)
        
        // Add parentNode to scene
        sceneView.scene.rootNode.addChildNode(parentNode)
    }
    
    func renderer(_ renderer: any SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
//TODO
    }
    
}
