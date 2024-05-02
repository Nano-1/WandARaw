//
//  PortalService.swift
//  WandARaw
//
//  Created by Sherly Phangestu on 30/04/24.
//

import ARKit

class PortalService{
    let sceneView: ARSCNView = ARManager.shared.portalSceneView
    
    let wallWidth: CGFloat = 0.03
    let wallHeight: CGFloat = 3
    let wallLength: CGFloat = 5
    
    func createVisibleInvisibleWall(isDoor: Bool, isBottom: Bool = false, isTop: Bool = false) -> SCNNode {
        // Parent Node
        let parentNode = SCNNode()
        
        // Child Node
        // 1. Visible Wall
        let visibleWall = SCNBox(width: wallWidth, height: (isBottom || isTop) ? wallLength : wallHeight, length: isDoor ? wallLength/2 : wallLength, chamferRadius: 100)
        // visibleWall.firstMaterial?.diffuse.contents = isBottom ? UIImage(named: "grass ground.jpg") : UIImage(named: "sky.jpg")
        visibleWall.firstMaterial?.diffuse.contents = UIImage(named: "Wood Wallpaper.jpg")
        let visibleWallNode = SCNNode(geometry: visibleWall)
        visibleWallNode.renderingOrder = 200
        
        parentNode.addChildNode(visibleWallNode)
        
        // 2. Invisible Wall
        let invisibleWall = SCNBox(width: wallWidth, height: (isBottom || isTop) ? wallLength : wallHeight, length: isDoor ? wallLength/2 : wallLength, chamferRadius: 100)
        invisibleWall.firstMaterial?.diffuse.contents = UIColor.white
        invisibleWall.firstMaterial?.transparency = 0.000000001
        let invisibleWallNode = SCNNode(geometry: invisibleWall)
        invisibleWallNode.renderingOrder = 100
        
        // Make an invisible wall to the right of the visible wall
        invisibleWallNode.position = SCNVector3(wallWidth, 0, 0)
        
        parentNode.addChildNode(invisibleWallNode)
        
        return parentNode
    }
    
    func addObjectDecoration() -> SCNNode{
        // Parent Node
        let parentNode = SCNNode()
    
        // Sword 1
        let swordNode1 = convert3DFileIntoNode(fileName: "Stylized_Sword.scn", position: SCNVector3(-1, 0, -1))
        parentNode.addChildNode(swordNode1)
        
        // Book 1
        let bookNode1 = convert3DFileIntoNode(fileName: "Viking_book.scn", position: SCNVector3(-1, 0, -1))
        parentNode.addChildNode(bookNode1)
        
        // TODO: SWORD 2, BOOK 2
        // Sword 2
        let swordNode2 = convert3DFileIntoNode(fileName: "Stylized_Sword.scn", position: SCNVector3(0, 0, -1))
        parentNode.addChildNode(swordNode2)
        
        // Book 2
        let bookNode2 = convert3DFileIntoNode(fileName: "Viking_book.scn", position: SCNVector3(0, 0, -1))
        parentNode.addChildNode(bookNode2)
        
        
        // Sword 3
        let swordNode3 = convert3DFileIntoNode(fileName: "Stylized_Sword.scn", position: SCNVector3(1, 0, -1))
        parentNode.addChildNode(swordNode3)
        
        // Book 3
        let bookNode3 = convert3DFileIntoNode(fileName: "Viking_book.scn", position: SCNVector3(1, 0, -1))
        parentNode.addChildNode(bookNode3)
        
        return parentNode
    }
    
    func convertDegreeToRadiant(degree: CFloat) -> CFloat{
        return degree * .pi / 180
    }
    
    func convert3DFileIntoNode(fileName: String, position: SCNVector3) -> SCNNode{
        var rootNode = SCNNode()
        if let scene = SCNScene(named: fileName){
            rootNode = scene.rootNode
            rootNode.position = position
        }else{
            print("\(fileName) not found")
        }
        return rootNode
    }
}
