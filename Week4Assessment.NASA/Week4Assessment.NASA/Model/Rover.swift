//
//  Rover.swift
//  Week4Assessment.NASA
//
//  Created by Jake Gloschat on 2/25/23.
//

import Foundation

class Rover {
    
    let cameraName: String
    let picturePath: String
    
    enum Keys: String {
        case photosArray = "photos"
        case camera
        case cameraName = "full_name"
        case roverDict
        case picturePath = "img_src"
        
    }
        
    init?(photosDict: [String: Any]) {
        guard let picturePath = photosDict[Keys.picturePath.rawValue] as? String,
              let cameraDict = photosDict[Keys.camera.rawValue] as? [String:Any],
              let cameraName = cameraDict[Keys.cameraName.rawValue] as? String else {return nil}
        
        self.cameraName = cameraName
        self.picturePath = picturePath
    }
}
