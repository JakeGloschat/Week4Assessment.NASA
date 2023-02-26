//
//  Rover.swift
//  Week4Assessment.NASA
//
//  Created by Jake Gloschat on 2/25/23.
//

import Foundation

class Rover {
    
    let photos: [String: Any]
    let cameraDict: [String: Any]
    let cameraName: String
    let earthDate: String
    let roverDict: [String: Any]
    let roverName: String
    let picturePath: String
    
    enum Keys: String {
        case photos
        case camera
        case cameraName = "full_name"
        case earthDate = "earth_date"
        case roverDict
        case roverName = "rover"
        case picturePath = "img_src"
        
    }
    
    init?(dictionary: [String : Any]) {
        guard let photos = dictionary[Keys.photos.rawValue] as? [String: Any],
              let cameraDict = dictionary["camera"] as? [String : Any],
              let cameraName = cameraDict[Keys.cameraName.rawValue] as? String,
              let earthDate = dictionary[Keys.earthDate.rawValue] as? String,
              let roverDict = dictionary["rover"] as? [String: Any],
              let roverName = roverDict[Keys.roverName.rawValue] as? String,
              let picturePath = dictionary[Keys.picturePath.rawValue] as? String else { return nil}
              
        self.photos = photos
        self.cameraDict = cameraDict
        self.cameraName = cameraName
        self.earthDate = earthDate
        self.roverDict = roverDict
        self.roverName = roverName
        self.picturePath = picturePath
    }
    
}
