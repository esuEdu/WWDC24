//
//  File.swift
//
//
//  Created by Eduardo on 08/02/24.
//

import Foundation
import RealityKit
import ARKit
import Combine

class CancellableManager {
    static let shared = CancellableManager()
    
    var cancellables = Set<AnyCancellable>()
    
    func add(_ cancellable: AnyCancellable) {
        cancellables.insert(cancellable)
    }
    
    func removeAll() {
        cancellables.removeAll()
    }
}


extension ARView: ARCoachingOverlayViewDelegate {
    
    func addCoaching() {
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coachingOverlay.goal = .horizontalPlane
        coachingOverlay.session = self.session
        coachingOverlay.delegate = self
        self.addSubview(coachingOverlay)
    }
    
    //When finish to analyze the surface add models
    public func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
        addModels()
    }
    
    //add Room and Control models using combine to do asynchronous loading
    private func addModels() {
        guard let anchor = self.scene.anchors.first(where: { $0.name == "Plane Anchor"}) else {
            return
        }
        
        let modelNames = ["Room", "Control"] // Names of the models to load
        
        let modelLoaders = modelNames.map { modelName in
            ModelEntity.loadModelAsync(named: modelName)
        }
        
        Publishers.Sequence(sequence: modelLoaders)
            .flatMap { $0 }
            .collect()
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .finished:
                        print("All models loaded successfully")
                    case .failure(let error):
                        print("Failed to load models: \(error)")
                }
            }, receiveValue: { models in
                // Create a parent entity to contain all the models
                let parentEntity = ModelEntity()
                
                // Add each model as a child of the parent entity
                for model in models {
                    if model == models.first {
                        model.name = "Room"
                        model.generateCollisionShapes(recursive: false)
                        parentEntity.addChild(model)
                        
                    } else {
                        model.name = "Control"
                        model.position = SIMD3<Float>(x: 0, y: 0, z: -0.1)
                        parentEntity.addChild(model)
                    }
                }
                
                // Add the parent entity to the anchor
                parentEntity.generateCollisionShapes(recursive: true)
                anchor.addChild(parentEntity)
                self.installGestures(.all, for: parentEntity)
                
            })
            .store(in: &CancellableManager.shared.cancellables)
    }
}
