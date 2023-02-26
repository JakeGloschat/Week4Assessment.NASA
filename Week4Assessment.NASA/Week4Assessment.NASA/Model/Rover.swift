//
//  Rover.swift
//  Week4Assessment.NASA
//
//  Created by Jake Gloschat on 2/25/23.
//

import Foundation

class Rover {
    
//    let photosArray: [[String: Any]]
//    let cameraDict: [String: Any]
    let cameraName: String
//    let roverDict: [String: Any]
    let picturePath: String
    
    enum Keys: String {
        case photosArray = "photos"
        case camera
        case cameraName = "full_name"
        case roverDict
        case picturePath = "img_src"
        
    }
    
//    init?(TopLevelDictionary: [String : Any]) {
//        guard let photosArray = TopLevelDictionary[Keys.photosArray.rawValue] as? [[String : Any]] else { return nil }
//
//       // var photos: [String] = []
//        var tempName = ""
//        var tempPath = ""
//        for dict in photosArray {
//            guard let cameraDict = dict[Keys.camera.rawValue] as? [String : Any],
//                  let picturePath = dict[Keys.picturePath.rawValue] as? String,
//                  let cameraName = cameraDict[Keys.cameraName.rawValue] as? String else { return nil }
//            tempName = cameraName
//            tempPath = picturePath
//        }
//
////        self.photosArray = photosArray
////        self.cameraDict = cameraDict
//        self.cameraName = tempName
//        self.picturePath = tempPath
//    }
    
    init?(photosDict: [String: Any]) {
        guard let posterPath = photosDict[Keys.photosArray.rawValue] as? String,
              let cameraDict = photosDict[Keys.camera.rawValue] as? [String:Any],
              let cameraName = cameraDict[Keys.picturePath.rawValue] as? String else {return nil}
        
        self.cameraName = cameraName
        self.picturePath = posterPath
    }
}
