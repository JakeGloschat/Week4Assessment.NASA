//
//  Constants.swift
//  Week4Assessment.NASA
//
//  Created by Jake Gloschat on 2/25/23.
//

import Foundation

struct Constants {
    
    struct NasaURL {
        static let baseURL = "https://api.nasa.gov/mars-photos/api/v1/rovers/"
        static let opportunityPath = "opportunity/photos"
        static let curiosityPath = "curiosity/photos"
        static let spiritPath = "spirit/photos"
    }
    
    struct APIQueryKey {
        static let earthDateQueryKey = "earth_date"
        static let apiKeyKey = "api_key"
        static let apiKeyValue = "yoJFuCab70ggeMgN3YHDJaxb8pq23Ga7QHNrwhTq"
        
    }
}
