// Copyright (c) 2022 Mark Horgan
//
// This source code is for individual learning purposes only. You may not copy,
// modify, merge, publish, distribute, create a derivative work or sell copies
// of the software in any work that is intended for pedagogical or
// instructional purposes.

import RealityKit
import ARKit

enum ModelType {
    case usdz
    case programatic
}

class CustomARView: ARView {
    private var anchorEntity: AnchorEntity!
    
    required init(frame: CGRect) {
        super.init(frame: frame)
        
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        session.run(config, options: [])
                
        anchorEntity = AnchorEntity(plane: .horizontal)
        scene.addAnchor(anchorEntity)
                
        addCoaching()
    }
    
    @objc required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setModel(_ modelType: ModelType) {
        switch modelType {
        case .usdz: addUSDZModel()
        case .programatic: addProgmaticModel()
        }
    }
    
    private func addUSDZModel() {
        anchorEntity.children.removeAll()

        let model = try! Entity.load(named: "Experience")
        anchorEntity.addChild(model)
    }
    
    private func addProgmaticModel() {
        anchorEntity.children.removeAll()

        let material = SimpleMaterial(color: .white, roughness: 1, isMetallic: false)

        let box1 = ModelEntity(mesh: .generateBox(size: [0.05, 0.03, 0.05]), materials: [material])
        box1.position = [0, 0.015, 0]
        anchorEntity.addChild(box1)

        let box2 = ModelEntity(mesh: .generateBox(size: [0.15, 0.03, 0.05]), materials: [material])
        box2.position = [0.05, 0.045, 0]
        anchorEntity.addChild(box2)

        let box3 = ModelEntity(mesh: .generateBox(size: [0.01, 0.05, 0.01]), materials: [material])
        box3.position = [0, 0.085, 0]
        anchorEntity.addChild(box3)
    }
    
    private func addCoaching() {
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.session = session
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coachingOverlay.goal = .horizontalPlane
        self.addSubview(coachingOverlay)
    }
}
