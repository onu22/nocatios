//
//  NetworkDataService.swift
//  nocat
//
//  Created by Onuorah Nwachukwu on 17/06/2020.
//  Copyright © 2020 Onuorah Nwachukwu. All rights reserved.
//

import Foundation

class NetworkDataService {
      static let shared = NetworkDataService()
    
    func getUsers(completion: @escaping (Result<[nocatUser], Error>) -> Void) {
        var componentURL = URLComponents()
        componentURL.scheme = "https"
        componentURL.host = "nocat-on-azure-1591015625411.azurewebsites.net"
        componentURL.path = "/api/users/"

        guard let validURL = componentURL.url else {
            print("URL creation failed...")
            return
        }
        
        URLSession.shared.dataTask(with: validURL) { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse {
                print("API status: \(httpResponse.statusCode)")
            }
            
            guard let validData = data, error == nil else {
                completion(.failure(error!))
                return
            }
            
            do {
                //let json = try JSONSerialization.jsonObject(with: validData, options: [])
                let users = try JSONDecoder().decode([nocatUser].self, from: validData)
                completion(.success(users))
            } catch let serializationError {
                completion(.failure(serializationError))
            }
            
        }.resume()
        
    }

}
