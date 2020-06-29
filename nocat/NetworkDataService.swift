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
        let componentURL = createURLComponents(path: "/api/users/")
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
                let users = try JSONDecoder().decode([nocatUser].self, from: validData)
                completion(.success(users))
            } catch let serializationError {
                completion(.failure(serializationError))
            }
            
        }.resume()
        
    }
    
    func getNeighbours(completion: @escaping (Result<[nocatUser], Error>) -> Void) {
        
        let putComponents = createURLComponents(path: "/api/neigh/getall")
        guard let composedURL = putComponents.url else {
            print("URL creation failed...")
            return
        }
        
        var putRequest = URLRequest(url: composedURL)
        putRequest.httpMethod = "PUT"
        putRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        putRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        let user = nocatUser(id: 1, deviceId: "1112", userName: "pmanonu 1",
                                  latitude:43.650715,longitude:-79.377161)
        
        do {
            let userData = try JSONEncoder().encode(user)
            putRequest.httpBody = userData
        } catch {
            print("nocatUser encoding failed...")
        }
        
        URLSession.shared.dataTask(with: putRequest) { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse {
                print("API status: \(httpResponse.statusCode)")
            }
            
            guard let validData = data, error == nil else {
                completion(.failure(error!))
                return
            }
            
            do {
                let users = try JSONDecoder().decode([nocatUser].self, from: validData)
                print(users)
                completion(.success(users))
                
            } catch let serializationError {
                completion(.failure(serializationError))
            }
            
        }.resume()
    }
    
    
    func createURLComponents(path: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "nocat-on-azure-1591015625411.azurewebsites.net"
        components.path = path
        
        return components
    }
    

}
