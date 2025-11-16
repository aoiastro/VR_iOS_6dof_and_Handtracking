import SwiftUI
import RealityKit
import ARKit
import Vision

struct VRViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        // 6DoF World Tracking
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        config.environmentTexturing = .automatic
        config.sceneReconstruction = .mesh
        arView.session.run(config)
        
        // 左右2画面用ビューポート
        arView.contentMode = .scaleAspectFill
        
        // 掴める板を作る
        let box = MeshResource.generateBox(size: 0.1)
        let material = SimpleMaterial(color: .blue, isMetallic: false)
        let entity = ModelEntity(mesh: box, materials: [material])
        entity.generateCollisionShapes(recursive: true)
        
        // ハンドトラッキング用
        arView.installGestures([.translation, .rotation], for: entity)
        
        let anchor = AnchorEntity(world: [0, 0, -0.5])
        anchor.addChild(entity)
        arView.scene.addAnchor(anchor)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
}
