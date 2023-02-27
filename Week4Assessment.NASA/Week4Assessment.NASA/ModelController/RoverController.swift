//
//  RoverController.swift
//  Week4Assessment.NASA
//
//  Created by Jake Gloschat on 2/25/23.
//

import UIKit

class RoverController {
    
    static func fetchRover(selectedRover: Int, searchDate: String, completion: @escaping ([Rover]?) -> Void) {

        // MARK: - Construct URL
        guard let baseURL = URL(string: Constants.NasaURL.baseURL) else { completion(nil) ; return }
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        var roverPath = ""
        switch selectedRover {
        case 0:
            roverPath = Constants.NasaURL.spiritPath
        case 1:
            roverPath = Constants.NasaURL.opportunityPath
        case 2:
            roverPath = Constants.NasaURL.curiosityPath
        default:
            return
        }
        
        urlComponents?.path.append(roverPath)
        
        let earthDateQuery = URLQueryItem(name: Constants.APIQueryKey.earthDateQueryKey, value: searchDate)
        let apiQuery = URLQueryItem(name: Constants.APIQueryKey.apiKeyKey, value: Constants.APIQueryKey.apiKeyValue)
        
        urlComponents?.queryItems = [earthDateQuery, apiQuery]
        
        guard let finalURL = urlComponents?.url else { completion(nil) ; return }
        print("Curiosity Rover FinalURL: \(finalURL)")
        
        // MARK: - DataTask
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil) ; return
            }
            
            if let response = response as? HTTPURLResponse {
                print("NASA Response Status Code: \(response.statusCode)")
            }
            
            guard let data = data else { completion(nil) ; return }
            
            do {
                if let topLevel = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed ) as? [String : Any], let photosArray = topLevel["photos"] as? [[String : Any]] {
 
                    let rovers = photosArray.compactMap({Rover(photosDict: $0)})
                    completion(rovers)
                }
            } catch {
                print(error.localizedDescription)
                completion(nil)
                return
            }
        }.resume()
    }
    
    static func fetchImage(forRover: Rover, completion: @escaping (UIImage?) -> Void) {
        guard let finalURL = URL(string: forRover.picturePath) else { completion(nil) ; return }
        
        // MARK: - DataTask
        URLSession.shared.dataTask(with: finalURL) { data, _, error in
            if let error = error {
                print("There was an error fetching the data. The URL is \(finalURL), the error is \(error.localizedDescription)")
            }
            
            guard let data = data else { completion(nil) ; return }
            
            let marsImage = UIImage(data: data)
            completion(marsImage)
            
        }.resume()
    }
}
