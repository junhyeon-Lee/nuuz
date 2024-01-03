//
//  ViewController.swift
//  ios_2mm
//
//  Created by Aleksandra on 30.05.2023.
//

import UIKit
import ARKit

enum AllAreas: String, CaseIterable {
    case leftForehead1 = "leftForehead1"
    case leftEye = "leftEye"
    case leftCheek = "leftCheek"
    case leftForehead2 = "leftForehead2"
    case leftNeck = "leftNeck"
    case rightForehead1 = "rightForehead1"
    case rightEye = "rightEye"
    case rightCheek = "rightCheek"
    case rightForehead2 = "rightForehead2"
    case rightNeck = "rightNeck"
}

class ViewController: UIViewController {
    // MARK: Subviews
    private let sceneView = ARSCNView()
    private let modeButton = UIButton()
    private let positionButton = UIButton()
    private let stackOfButtons = UIStackView()
    
    // MARK: - Properties
    private var allElements = AllAreas.allCases.map { $0.rawValue }
    private var currentIndex = 0
    private var isLeftNeck = false
    private var isRightNeck = false
    
    private let leftNeckVertices = [208, 392]
    private let rightNeckVertices = [1060, 1216]
    
    private var contentNode: SCNNode?
    private var faceGeometry: ARSCNFaceGeometry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard ARFaceTrackingConfiguration.isSupported else {
            fatalError("Face tracking is not supported on this device")
        }
        setupUI()
        setupLayout()
        sceneView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARFaceTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
}

// MARK: - ARSCNViewDelegate
extension ViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        guard let sceneView = renderer as? ARSCNView,
              let faceAnchor = anchor as? ARFaceAnchor else { return nil }
        
        faceGeometry = ARSCNFaceGeometry(device: sceneView.device!)!
        let material = faceGeometry?.firstMaterial
        
        material?.diffuse.contents = UIImage(named: AllAreas.leftForehead1.rawValue)
        material?.lightingModel = .physicallyBased
        
        contentNode = SCNNode(geometry: faceGeometry)
        
        let leftNeckNode = ImageNode(imageName: AllAreas.leftNeck.rawValue)
        leftNeckNode.name = AllAreas.leftNeck.rawValue
        leftNeckNode.isHidden = true
        contentNode?.addChildNode(leftNeckNode)
        let leftVertices = leftNeckVertices.compactMap { index -> vector_float3? in
            return faceAnchor.geometry.vertices[index]
        }
        leftNeckNode.updatePosition(for: leftVertices, angle: -1)
        
        let rightNeckNode = ImageNode(imageName: AllAreas.rightNeck.rawValue)
        rightNeckNode.name = AllAreas.rightNeck.rawValue
        rightNeckNode.isHidden = true
        contentNode?.addChildNode(rightNeckNode)
        let rightVertices = rightNeckVertices.compactMap { index -> vector_float3? in
            return faceAnchor.geometry.vertices[index]
        }
        rightNeckNode.updatePosition(for: rightVertices, angle: 1)
        
        return contentNode
    }
    
    func renderer(
        _ renderer: SCNSceneRenderer,
        didUpdate node: SCNNode,
        for anchor: ARAnchor) {
            
            guard let faceAnchor = anchor as? ARFaceAnchor,
                  let faceGeometry = node.geometry as? ARSCNFaceGeometry,
                  let leftNeck = contentNode?.childNode(withName: AllAreas.leftNeck.rawValue,
                                                        recursively: true) as? ImageNode,
                  let rightNeck = contentNode?.childNode(withName: AllAreas.rightNeck.rawValue,
                                                         recursively: true) as? ImageNode else {
                return
            }
            
            faceGeometry.update(from: faceAnchor.geometry)
            leftNeck.isHidden = !isLeftNeck
            rightNeck.isHidden = !isRightNeck
            
            let leftVertices = leftNeckVertices.compactMap { index -> vector_float3? in
                return faceAnchor.geometry.vertices[index]
            }
            
            let rightVertices = rightNeckVertices.compactMap { index -> vector_float3? in
                return faceAnchor.geometry.vertices[index]
            }
            
            leftNeck.updatePosition(for: leftVertices, angle: -1)
            rightNeck.updatePosition(for: rightVertices, angle: 1)
        }
}

// MARK: - Action for buttons
private extension ViewController {
    @objc func modeButtonPressed() {
        print(#function)
    }
    
    @objc func positionButtonPressed() {
        currentIndex = (currentIndex + 1) % allElements.count
        let material = faceGeometry?.firstMaterial
        isRightNeck = false
        isLeftNeck = false
        
        guard  allElements[currentIndex] == AllAreas.leftNeck.rawValue ||
                allElements[currentIndex] == AllAreas.rightNeck.rawValue else {
            material?.diffuse.contents = UIImage(named: allElements[currentIndex])
            return
        }
        
        material?.diffuse.contents = UIImage(named: "clearFace")
        
        if allElements[currentIndex] == AllAreas.leftNeck.rawValue {
            isLeftNeck = true
            isRightNeck = false
        } else {
            isLeftNeck = false
        }
        
        if allElements[currentIndex] == AllAreas.rightNeck.rawValue {
            isRightNeck = true
            isLeftNeck = false
        } else {
            isRightNeck = false
        }
    }
}

// MARK: - Setup UI
private extension ViewController {
    func setupUI() {
        modeButton.backgroundColor = .blue
        modeButton.setTitle("change mode", for: .normal)
        modeButton.addTarget(self,
                             action: #selector(modeButtonPressed),
                             for: .touchUpInside)
        modeButton.layer.cornerRadius = 7
        modeButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        modeButton.setTitleColor(.black, for: .normal)
        
        positionButton.backgroundColor = .blue
        positionButton.setTitle("change position", for: .normal)
        positionButton.addTarget(self,
                                 action: #selector(positionButtonPressed),
                                 for: .touchUpInside)
        positionButton.layer.cornerRadius = 7
        positionButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        positionButton.setTitleColor(.black, for: .normal)
        
        stackOfButtons.axis = .horizontal
        stackOfButtons.distribution = .fillEqually
        stackOfButtons.addArrangedSubview(modeButton)
        stackOfButtons.addArrangedSubview(positionButton)
        stackOfButtons.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupLayout() {
        view.addSubview(sceneView)
        sceneView.frame = view.bounds
        
        view.addSubview(stackOfButtons)
        NSLayoutConstraint.activate([
            modeButton.heightAnchor.constraint(equalToConstant: 44),
            positionButton.heightAnchor.constraint(equalToConstant: 44),
            stackOfButtons.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackOfButtons.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}
