//
//  RoverController.swift
//  Week4Assessment.NASA
//
//  Created by Jake Gloschat on 2/25/23.
//

import UIKit

class CuriosityController {
    //https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=2015-6-3&api_key=yoJFuCab70ggeMgN3YHDJaxb8pq23Ga7QHNrwhTq
    
    static func fetchRover(roverSearchTerm: String, searchDate: String, completion: @escaping ([Rover]?) -> Void) {
        
        // MARK: - Construct URL
        guard let baseURL = URL(string: Constants.NasaURL.baseURL) else { completion(nil) ; return }
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        // TODO: - Update Curiosity Path to use the roverSearchTerm
        urlComponents?.path.append(Constants.NasaURL.curiosityPath)
        
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
                if let topLevel = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String : Any], let photosArray = topLevel["photos"] as? [[String:Any]] {
                    
                    
                    //                    var tempArray: [Rover] = []
                    //
                    //                    for dict in photosArray {
                    //                        guard let rover = Rover(photosDict: dict) else {return}
                    //                        tempArray.append(rover)
                    //                    }
                    //                    completion(tempArray)
                    
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

