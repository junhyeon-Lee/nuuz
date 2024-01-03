//
//  ImageNode.swift
//  ios_2mm
//
//  Created by Aleksandra on 06.06.2023.
//

import Foundation
import ARKit

class ImageNode: SCNNode {
    var imageName: String
    
    init(imageName: String) {
        self.imageName = imageName
        super.init()
        
        let plane = SCNPlane(width: 0.05, height: 0.05)
        plane.firstMaterial?.diffuse.contents = UIImage(named: imageName)
        plane.firstMaterial?.isDoubleSided = true
        geometry = plane
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Update position
extension ImageNode {
    func updatePosition(for vectors: [vector_float3], angle: Int) {
        let averagePosition = vectors.reduce(vector_float3(), +) / Float(vectors.count)
        let lowerAmount: Float = 0.05
        
        let newPosition = SCNVector3(x: averagePosition.x, y: averagePosition.y - lowerAmount, z: averagePosition.z)
        position = newPosition
        
        let rotation = SCNVector3(0, angle, 0)
        eulerAngles = rotation
    }
}

