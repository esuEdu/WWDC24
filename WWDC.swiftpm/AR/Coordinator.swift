//
//  Coordinator.swift
//
//
//  Created by Eduardo on 05/02/24.
//

import Foundation
import ARKit
import RealityKit
import Combine

class Coordinator: NSObject, ARSessionDelegate {
    
    weak var view: ARView?
    weak var gameController: GameController?
    
    // Handle tap gesture
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        guard let arView = self.view else { return }
        guard let gameController = self.gameController else { return }
        
        let tapLocation = gesture.location(in: arView)
        
        // Perform ray cast through the tap location
        if let raycast = arView.ray(through: tapLocation) {
            let result = arView.scene.raycast(origin: raycast.origin, direction: raycast.origin + raycast.direction * 100, query: .all, mask: .default)
            // Iterate through hit results
            for hitResult in result {
                if hitResult.entity.name == "Control" {
                    gameController.isARVisible.toggle()
                }
            }
        }
    }
}
