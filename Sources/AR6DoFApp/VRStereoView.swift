import SwiftUI
import ARKit
import RealityKit

struct VRStereoView: UIViewRepresentable {

    func makeUIView(context: Context) -> UIView {

        // 左右のビュー
        let leftView = ARView(frame: .zero)
        let rightView = ARView(frame: .zero)

        // 6DoF設定
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        config.environmentTexturing = .automatic
        leftView.session.run(config)
        rightView.session.run(config)

        // シーン共有（RealityKitは共有可能）
        rightView.scene = leftView.scene

        // IPD（視差）
        let ipd: Float = 0.063 // 基準64mm

        leftView.cameraTransform.translation.x = -ipd / 2
        rightView.cameraTransform.translation.x =  ipd / 2

        // 掴める板
        let plate = ModelEntity(
            mesh: .generateBox(size: 0.15),
            materials: [SimpleMaterial(color: .blue, isMetallic: false)]
        )
        plate.generateCollisionShapes(recursive: true)
        leftView.installGestures([.translation, .rotation], for: plate)

        let anchor = AnchorEntity(world: [0, 0, -0.7])
        anchor.addChild(plate)
        leftView.scene.addAnchor(anchor)

        // UIレイアウト（左右並列）
        let container = UIView()
        container.backgroundColor = .black

        leftView.translatesAutoresizingMaskIntoConstraints = false
        rightView.translatesAutoresizingMaskIntoConstraints = false

        container.addSubview(leftView)
        container.addSubview(rightView)

        NSLayoutConstraint.activate([
            leftView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            leftView.topAnchor.constraint(equalTo: container.topAnchor),
            leftView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            leftView.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.5),

            rightView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            rightView.topAnchor.constraint(equalTo: container.topAnchor),
            rightView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            rightView.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.5),
        ])

        return container
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

