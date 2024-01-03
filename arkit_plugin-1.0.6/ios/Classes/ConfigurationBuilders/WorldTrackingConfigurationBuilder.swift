import Foundation
import ARKit

func createWorldTrackingConfiguration(_ arguments: Dictionary<String, Any>) -> ARWorldTrackingConfiguration? {
    if(ARWorldTrackingConfiguration.isSupported) {
        let worldTrackingConfiguration = ARWorldTrackingConfiguration()
        if #available(iOS 12.0, *) {
          if let environmentTexturing = arguments["environmentTexturing"] as? Int {
            if environmentTexturing == 0 {
              worldTrackingConfiguration.environmentTexturing = .none
            }
            else if environmentTexturing == 1 {
              worldTrackingConfiguration.environmentTexturing = .manual
            }
            else if environmentTexturing == 2 {
              worldTrackingConfiguration.environmentTexturing = .automatic
            }
          }
        }
        if let planeDetection = arguments["planeDetection"] as? Int {
            if planeDetection == 1 {
                worldTrackingConfiguration.planeDetection = .horizontal
            }
            if planeDetection == 2 {
                if #available(iOS 11.3, *) {
                    worldTrackingConfiguration.planeDetection = .vertical
                }
            }
             if planeDetection == 3 {
                 if #available(iOS 11.3, *) {
                    worldTrackingConfiguration.planeDetection = [.horizontal, .vertical]
                 }
             }
        }
        if #available(iOS 11.3, *) {
            if let detectionImagesGroupName = arguments["detectionImagesGroupName"] as? String {
                worldTrackingConfiguration.detectionImages = ARReferenceImage.referenceImages(inGroupNamed: detectionImagesGroupName, bundle: nil)
            }
            if let detectionImages = arguments["detectionImages"] as? Array<Dictionary<String, Any>> {
                worldTrackingConfiguration.detectionImages = parseReferenceImagesSet(detectionImages)
            }
        }
        if #available(iOS 12.0, *) {
            if let maximumNumberOfTrackedImages = arguments["maximumNumberOfTrackedImages"] as? Int {
                worldTrackingConfiguration.maximumNumberOfTrackedImages = maximumNumberOfTrackedImages
            }
        }
        return worldTrackingConfiguration
    }
    return nil
}
