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

class ViewController: UIViewController, ARSCNViewDelegate {
    
//    let flashView = UIView()
    
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setupViews()
//        flashIndicator()
        
        sceneView = ARSCNView(frame: self.view.frame)
        self.view.addSubview(sceneView)
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // function add component
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
        sphere.geometry = SCNSphere(radius:0.0025)
        sphere.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        
        DrawingService.addChildNode(node: sphere, sceneView: sceneView)
        
    }
    
//    func flashIndicator(){
//        flashView.backgroundColor = .white
//        flashView.alpha = 0
//        flashView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(flashView)
//
//        // Add constraints to fill the entire view
//        NSLayoutConstraint.activate([
//            flashView.topAnchor.constraint(equalTo: view.topAnchor),
//            flashView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            flashView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            flashView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//    }
//    
//    func setupViews(){
//        let crosshair = UITextView(frame: CGRect(x: (UIScreen.main.bounds.maxX/2)-10, y: (UIScreen.main.bounds.maxY/2)-10, width: 50, height: 50))
//        crosshair.text = "+"
//        crosshair.isEditable = false
//        crosshair.backgroundColor = .clear
//        self.view.addSubview(crosshair)
//        
//        let button = UIButton(frame: CGRect(x: (UIScreen.main.bounds.maxX/2)-50, y: UIScreen.main.bounds.maxY-200, width: 100, height: 50))
//        button.setTitle("Tap Me", for: .normal)
//        button.backgroundColor = .blue
//        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
//        self.view.addSubview(button)
//    }
//    
//    @objc func buttonTapped() {
//        UIImageWriteToSavedPhotosAlbum(sceneView.snapshot(), self, #selector(saveCompleted), nil)
//    }
//    
//    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
//        flashView.alpha = 1
//                UIView.animate(withDuration: 0.3, animations: {
//                    self.flashView.alpha = 0
//                })
//    }
}
