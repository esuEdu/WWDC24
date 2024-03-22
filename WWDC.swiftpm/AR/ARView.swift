//
//  ARView.swift
//
//
//  Created by Eduardo on 04/02/24.
//

import Foundation
import RealityKit
import SwiftUI

struct ARViewContainer: UIViewRepresentable {
    
    @ObservedObject var gameController: GameController
    
    func makeUIView(context: Context) -> ARView {
                
        let arView = ARView(frame: .zero)
        
        //Create and add anchor to the view
        let anchor = AnchorEntity(plane: .horizontal)
        anchor.name = "Plane Anchor"
        arView.scene.addAnchor(anchor)
        
        //create coordinator to control models
        context.coordinator.view = arView
        context.coordinator.gameController = gameController
        arView.session.delegate = context.coordinator
        //add Coaching to the view
        arView.addCoaching()
        
        //add gesture recognizers
        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handleTap(_:)))
        arView.addGestureRecognizer(tapGesture)
        
        return arView
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
}
